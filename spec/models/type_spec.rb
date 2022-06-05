require('rails_helper')

RSpec.describe(Type, type: :model) do

  subject(:model) do
    described_class.new(id: id, name: name)
  end

  let(:id) { 'id' }
  let(:name) { 'name' }

  it('is valid with all attributes') do
    expect(model).to be_valid
  end

  context('when the id is not present') do
    let(:id) { nil }

    it('raises a validation error') do
      expect(model).to_not be_valid
    end
  end

  context('when the name is not present') do
    let(:name) { nil }

    it('raises a validation error') do
      expect(model).to_not be_valid
    end
  end

end
