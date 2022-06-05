require('rails_helper')

RSpec.describe('Pokemons', type: :request) do
  let(:user) { create(:user) }
  let(:headers) { authenticated_headers(user: user) }
  let(:params) { {} }

  let(:pokemons) do
    # I'm customizing the `created_at` to ensure the expected order is equal to the API controller result order
    now = Time.zone.now
    25.times.map { |i| create(:pokemon, created_at: now + i) }
  end

  before do
    pokemons
  end

  describe('index') do
    let(:page) { 1 }
    let(:per_page) { 20 }
    let(:fetched_pokemons) { pokemons.first(per_page) }

    let(:expected) do
      {
        count: pokemons.size,
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
        types: ActiveModel::SerializableResource.new(pokemon.types).as_json
      }
    end

    before do
      get("/api/pokemons/#{input_param}", headers: headers)
    end

    it('fetches the pokemon by id') do
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected)
    end

    context('when the input parameter is a string (pokemon name)') do
      let(:input_param) { pokemon.name }

      it('fetches the pokemon by id') do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected)
      end
    end
  end

end
