require('rails_helper')

RSpec.describe(PokemonHelper, type: :helper) do

  describe('calculate_level') do
    let(:pokemon) { create(:pokemon) }

    # This test should be changed accordingly to the real method implementation
    it('calculates the pokemon level') do
      expect(helper.calculate_level(pokemon)).to be_between(1, 100)
    end
  end

  describe('create_details_link') do
    let(:pokemon) { create(:pokemon) }

    it('creates the pokemon `details_link`') do
      expect(helper.create_details_link(pokemon)).to eq("/api/pokemons/#{pokemon.id}")
    end
  end

end
