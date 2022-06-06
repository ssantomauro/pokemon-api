require('rails_helper')

RSpec.describe('Admin::Pokemons', type: :request) do
  include(PokemonHelper)

  let(:user) { create(:user) }
  let(:headers) { authenticated_headers(user: user) }

  describe('create') do
    let(:name) { 'name' }
    let(:weight) { 0 }
    let(:height) { 0 }
    let(:sprite_url) { 'http://example.com/PokeAPI/sprite_url' }

    let(:params) do
      {
        name: name,
        weight: weight,
        height: height,
        sprite_url: sprite_url
      }
    end

    before do
      post('/api/admin/pokemons', params: params, headers: headers)
    end

    it('returns 401 when the user does not have the permissions') do
      expect(response.status).to be(401)
    end

    context('when the user has the permissions') do
      let(:user) { create(:user, :admin) }

      it('creates the pokemon and put into the `Location` header the details url') do
        pokemon = Pokemon.last
        expect(pokemon.category).to eq('custom')
        expect(response.headers['Location']).to eq(create_details_link(pokemon))
      end
    end

  end
end
