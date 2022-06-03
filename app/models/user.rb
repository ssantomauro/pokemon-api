# frozen_string_literal: true

class User < ApplicationRecord
  include(Devise::JWT::RevocationStrategies::JTIMatcher)

  devise(:database_authenticatable, :registerable, :jwt_authenticatable, jwt_revocation_strategy: self)

  # This validation is just because Devise performs the INSERT on the DB,
  # and raises a HTTP 500 due to the table constraint
  validates_uniqueness_of(:email)

end
