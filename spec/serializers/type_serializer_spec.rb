require('rails_helper')

RSpec.describe(TypeSerializer) do
  let(:type) { create(:type) }

  let(:serialized) { ActiveModel::SerializableResource.new(type).as_json }
  let(:expected_json) do
    { id: type.id, name: type.name }
  end

  it('serializes a type') do
    expect(serialized).to eq(expected_json)
  end
end
