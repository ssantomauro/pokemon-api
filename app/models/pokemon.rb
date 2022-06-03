class Pokemon < ApplicationRecord
  # In this case I could use the `has_and_belongs_to_many` because the exercise
  # doesn't use the relation (it is used only as association table).
  # However I used this way because in my experience is the more flexible way
  # if in the future the association table can become more complex or need validations.
  has_many(:pokemons_types, dependent: :destroy)
  has_many(:types, through: :pokemons_types)
end
