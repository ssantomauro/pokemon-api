class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    # I'm not setting any limit on the string field because I don't know
    # the Pokemon API specification, but in a production application
    # it's important to optimize the fields size
    create_table(:pokemons) do |t|
      t.string(:name, null: false)
      t.integer(:weight, null: false)
      t.integer(:height, null: false)
      t.string(:sprite_url, null: false)

      t.timestamps(null: false)
    end

    # Here I would probably add an index on 'name' looking at the information I have for this exercise,
    # the index is not necessary
  end
end
