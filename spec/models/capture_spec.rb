require('rails_helper')

RSpec.describe(Capture, type: :model) do
  subject(:model) do
    described_class.new(user: user, pokemon: pokemon, nickname: nickname, level: level)
  end
  let(:user) { create(:user) }
  let(:pokemon) { create(:pokemon) }
  let(:nickname) { 'nickname' }
  let(:level) { 50 }

  it('is valid with all attributes') do
    expect(model).to be_valid
  end

  context('when the level is out of range') do
    let(:level) { 200 }

    it('raises a validation error') do
      expect(model).to_not be_valid
    end
  end

  describe("associations") do
    it { should belong_to(:user).without_validating_presence }
    it { should belong_to(:pokemon).without_validating_presence }
  end

end
