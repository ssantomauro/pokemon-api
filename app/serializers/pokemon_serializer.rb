class PokemonSerializer < ActiveModel::Serializer

  attributes(:id, :name, :sprite_url, :weight, :height)
  has_many(:types)

end
