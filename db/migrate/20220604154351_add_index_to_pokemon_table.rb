class AddIndexToPokemonTable < ActiveRecord::Migration[5.2]

  def change
    add_index(:pokemons, :name, unique: true)
  end

end
