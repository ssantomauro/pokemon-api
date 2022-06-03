class CreatePokemonsTypes < ActiveRecord::Migration[5.2]
  def change
    # Even in this case the indexes should be better analyzed in a real environment,
    # based on the real features. Here I'm just using a standard way which in general is fine
    create_table(:pokemons_types) do |t|
      t.references(:pokemon, null: false, index: true)
      t.references(:type, type: :string, null: false, index: true)
    end
  end
end
