require('rails_helper')

RSpec.describe(Pokemon, type: :model) do
  subject(:model) do
    described_class.new(name: name, weight: weight, height: height, sprite_url: sprite_url)
  end

  let(:name) { 'name' }
  let(:weight) { 0 }
  let(:height) { 0 }
  let(:sprite_url) { 'http://example.com/PokeAPI/sprite_url' }

  it('is valid with all attributes') do
    expect(model).to be_valid
  end

  context('when the name is not present') do
    let(:name) { nil }

    it('raises a validation error') do
      expect(model).to_not be_valid
    end
  end

  context('when the weight is not present') do
    let(:weight) { nil }

    it('raises a validation error') do
      expect(model).to_not be_valid
    end
  end

  context('when the height is not present') do
    let(:height) { nil }

    it('raises a validation error') do
      expect(model).to_not be_valid
    end
  end

  context('when the sprite_url is not present') do
    let(:sprite_url) { nil }

    it('raises a validation error') do
      expect(model).to_not be_valid
    end

    context('when the sprite_url does not have a valid URL') do
      let(:sprite_url) { 'foo' }

      it('raises a validation error') do
        expect(model).to_not be_valid
      end
    end
  end

  describe("associations") do
    it { should have_many(:types) }
  end

end
