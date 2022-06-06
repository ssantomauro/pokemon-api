class User < ApplicationRecord

  ROLES = %w[user admin]

  include(Devise::JWT::RevocationStrategies::JTIMatcher)

  devise(:database_authenticatable, :registerable, :jwt_authenticatable, jwt_revocation_strategy: self)

  has_many(:captures, dependent: :destroy)

  # This validation is just because Devise performs the INSERT on the DB,
  # and raises a HTTP 500 due to the table constraint
  validates_uniqueness_of(:email)

  # I've implemented a simplified version of the real "Roles" implementation.
  # In a production environment I would create a `Role` and `UsersRole` models
  # (the most flexible way to handle many roles for a user) or only the `Role` model
  # (if a user can have only one role).
  validates(:role, presence: true, inclusion: { in: ROLES })

end
