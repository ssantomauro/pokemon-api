class PokemonsType < ApplicationRecord

  belongs_to(:pokemon)
  belongs_to(:type)

  # It's not really needed this validation.
  # By default, rails verifies the if the "belongs_to record" linked exists or not.
  # Adding the `validates_presence_of` just adds the validation for field blank
  # (which is a secondary check in this case)
  validates_presence_of(:pokemon, :type)

end
