require('rails_helper')

RSpec.describe(PokemonsType, type: :model) do

  describe('associations') do
    it { should belong_to(:pokemon).without_validating_presence }
    it { should belong_to(:type).without_validating_presence }
  end

end
