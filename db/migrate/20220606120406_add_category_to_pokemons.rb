class AddCategoryToPokemons < ActiveRecord::Migration[5.2]

  def change
    add_column(:pokemons, :category, :string, length: 20, null: false, default: 'real', after: :sprite_url)
  end

end
