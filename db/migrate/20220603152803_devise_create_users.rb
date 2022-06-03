# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]

  def change
    create_table(:users) do |t|
      t.string(:email, null: false, default: '')
      t.string(:encrypted_password, null: false, default: '')
      # I set 'null=true' because I didn't understand very well how I should use it
      # I can explain this during the interview
      t.string(:api_token, null: true)
      t.string(:jti, null: false)

      t.timestamps(null: false)
    end

    add_index(:users, :email, unique: true)
    add_index(:users, :jti, unique: true)
  end

end
