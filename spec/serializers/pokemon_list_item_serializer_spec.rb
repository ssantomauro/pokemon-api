require('rails_helper')

RSpec.describe(PokemonListItemSerializer) do
  let(:pokemon) { create(:pokemon) }

  let(:serialized) { ActiveModel::SerializableResource.new(pokemon, serializer: described_class).as_json }
  let(:expected_json) do
    {
      id: pokemon.id,
      name: pokemon.name,
      sprite_url: pokemon.sprite_url,
      details_link: "/api/pokemons/#{pokemon.id}"
    }
  end

  it('serializes a pokemon') do
    expect(serialized).to eq(expected_json)
  end
end
