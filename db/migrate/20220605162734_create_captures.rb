class CreateCaptures < ActiveRecord::Migration[5.2]
  def change
    create_table(:captures) do |t|
      t.references(:user, null: false)
      t.references(:pokemon, null: false)
      t.string(:nickname, null: true)
      t.integer(:level, null: false)

      t.timestamps(null: false)
    end
  end
end
