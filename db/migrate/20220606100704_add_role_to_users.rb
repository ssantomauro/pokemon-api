class AddRoleToUsers < ActiveRecord::Migration[5.2]

  def change
    add_column(:users, :role, :string, length: 20, null: false, default: 'user', after: :encrypted_password)
  end

end
