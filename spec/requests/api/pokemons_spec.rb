require('rails_helper')

RSpec.describe('Pokemons', type: :request) do
  let(:user) { create(:user) }
  let(:headers) { authenticated_headers(user: user) }
  let(:params) { {} }

  let(:pokemons) do
    # I'm customizing the `created_at` to ensure the expected order is equal to the API controller result order
    now = Time.zone.now
    pokemons = 25.times.map { |i| create(:pokemon, created_at: now + i) }
    # I'm adding 5 "real" pokemons
    pokemons += (25...30).map { |i| create(:pokemon, category: 'real', created_at: now + i) }

    pokemons
  end

  before do
    pokemons
  end

  describe('index') do
    let(:page) { 1 }
    let(:per_page) { 20 }
    let(:count) { pokemons.size }
    let(:fetched_pokemons) { pokemons.first(per_page) }

    let(:expected) do
      {
        count: count,
        page: page,
        per_page: per_page,
        results: ActiveModel::SerializableResource.new(fetched_pokemons, each_serializer: PokemonListItemSerializer).as_json
      }
    end

    before do
      get('/api/pokemons', params: params, headers: headers)
    end

    context('when no params specified') do
      it('fetches the first 20 pokemons') do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected)
      end
    end

    context('when `page` and `per_page` are specified') do
      let(:page) { 3 }
      let(:per_page) { 5 }
      let(:fetched_pokemons) { pokemons[per_page * (page - 1), per_page] }

      let(:params) do
        { page: page, per_page: per_page }
      end

      it('fetches `per_page` pokemons starting from the page `page`') do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected)
      end
    end

    context('when `category` is specified') do
      let(:fetched_pokemons) { pokemons.select { |pokemon| pokemon.category == 'real' } }
      let(:category) { 'real' }
      let(:count) { 5 }

      let(:params) do
        { category: category }
      end

      it('fetches the pokemons by `category`') do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected)
      end
    end
  end

  describe('show') do
    let(:pokemon) { pokemons[5] }
    let(:input_param) { pokemon.id }
    let(:expected) do
      {
        id: pokemon.id,
        name: pokemon.name,
        sprite_url: pokemon.sprite_url,
        weight: pokemon.weight,
        height: pokemon.height,
        category: pokemon.category,
        types: ActiveModel::SerializableResource.new(pokemon.types).as_json
      }
    end

    before do
      get("/api/pokemons/#{input_param}", headers: headers)
    end

    context('when the input parameter is an integer (pokemon id)') do
      it('fetches the pokemon by id') do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected)
      end

      context('when the pokemon with the id specified does not exists') do
        let(:input_param) { pokemons.length + 1 }

        it('raises a not found') do
          expect(response.status).to be(404)
        end
      end
    end

    context('when the input parameter is a string (pokemon name)') do
      let(:input_param) { pokemon.name }

      it('fetches the pokemon by name') do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected)
      end

      context('when the pokemon with the id specified does not exists') do
        let(:input_param) { 'foo' }

        it('raises a not found') do
          expect(response.status).to be(404)
        end
      end
    end
  end

  describe('capture') do
    let(:pokemon) { pokemons[5] }
    let(:input_param) { pokemon.id }
    let(:params) { {} }

    before do
      post("/api/pokemons/#{input_param}/capture", params: params, headers: headers)
    end

    it('creates a new capture record for the user') do
      expect(response.status).to be(200)

      capture = Capture.last
      expected = {
        nickname: nil,
        level: capture.level,
        pokemon: ActiveModel::SerializableResource.new(pokemon, serializer: PokemonListItemSerializer).as_json
      }
      expect(JSON.parse(response.body, symbolize_names: true)).to include(expected)
    end

    context('when the nickname is sent') do
      let(:params) do
        { nickname: 'custom_pokemon_name' }
      end

      it('creates a new capture record for the user') do
        expect(response.status).to be(200)

        capture = Capture.last
        expected = {
          nickname: params[:nickname],
          level: capture.level,
          pokemon: ActiveModel::SerializableResource.new(pokemon, serializer: PokemonListItemSerializer).as_json
        }
        expect(JSON.parse(response.body, symbolize_names: true)).to include(expected)
      end
    end

    context('when the pokemon with the id specified does not exists') do
      let(:input_param) { pokemons.length + 1 }

      it('raises a not found') do
        expect(response.status).to be(404)
      end
    end
  end

end
