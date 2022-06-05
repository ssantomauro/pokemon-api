require('rails_helper')

RSpec.describe(CaptureSerializer) do
  let(:user) { create(:user) }
  let(:pokemon) { create(:pokemon) }
  let(:nickname) { 'nickname' }
  let(:level) { 1 }

  let(:capture) do
    create(:capture, pokemon: pokemon, user: user, level: level, nickname: nickname)
  end

  let(:serialized) { ActiveModel::SerializableResource.new(capture).as_json }
  let(:expected_json) do
    {
      id: capture.id,
      nickname: capture.nickname,
      level: capture.level,
      pokemon: ActiveModel::SerializableResource.new(pokemon, serializer: PokemonListItemSerializer).as_json
    }
  end

  it('serializes a pokemon') do
    expect(serialized).to eq(expected_json)
  end
end
