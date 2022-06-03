class CreateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table(:types, id: :string) do |t|
      t.string(:name, null: false)

      t.timestamps(null: false)
    end
  end
end
