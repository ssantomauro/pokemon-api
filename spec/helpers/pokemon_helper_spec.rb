require('rails_helper')

RSpec.describe(PokemonHelper, type: :helper) do

  describe('calculate_level') do
    let(:pokemon) { create(:pokemon) }

    # This test should be changed accordingly to the real method implementation
    it('calculates the pokemon level') do
      expect(helper.calculate_level(pokemon: pokemon)).to be_between(1, 100)
    end
  end

end
