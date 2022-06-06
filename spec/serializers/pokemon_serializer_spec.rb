require('rails_helper')

RSpec.describe(PokemonSerializer) do
  let(:type1) { create(:type) }
  let(:type2) { create(:type) }
  let(:pokemon) do
    pokemon = create(:pokemon)
    pokemon.types << type1
    pokemon.types << type2
    pokemon
  end

  let(:serialized) { ActiveModel::SerializableResource.new(pokemon).as_json }
  let(:expected_json) do
    {
      id: pokemon.id,
      name: pokemon.name,
      sprite_url: pokemon.sprite_url,
      weight: pokemon.weight,
      height: pokemon.height,
      category: pokemon.category,
      types: ActiveModel::SerializableResource.new(pokemon.types).as_json
    }
  end

  it('serializes a pokemon') do
    expect(serialized).to eq(expected_json)
  end
end
