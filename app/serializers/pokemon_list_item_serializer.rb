class PokemonListItemSerializer < ActiveModel::Serializer

  attributes(:id, :name, :sprite_url, :details_link)

  def details_link
    "/api/pokemons/#{object.id}"
  end


end
