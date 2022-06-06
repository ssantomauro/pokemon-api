class PokemonListItemSerializer < ActiveModel::Serializer
  include(PokemonHelper)

  attributes(:id, :name, :sprite_url, :category, :details_link)

  def details_link
    create_details_link(object)
  end

end
