class PokemonSerializer < ActiveModel::Serializer

  attributes(:id, :name, :sprite_url, :weight, :height, :category)
  has_many(:types)

end
