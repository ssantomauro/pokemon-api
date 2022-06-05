class CaptureSerializer < ActiveModel::Serializer

  attributes(:id, :nickname, :level)
  belongs_to(:pokemon, serializer: PokemonListItemSerializer)

end
