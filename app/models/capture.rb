class Capture < ApplicationRecord

  default_scope { order(:created_at) }

  belongs_to(:user)
  belongs_to(:pokemon)

  # I'm not sure about this range. I don't know anything about the Pokemons world
  # and online I found so many different info
  validates_inclusion_of(:level, in: 1..100)

end
