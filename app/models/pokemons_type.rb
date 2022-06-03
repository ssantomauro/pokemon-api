class PokemonsType < ApplicationRecord
  belongs_to(:pokemon)
  belongs_to(:type)
end
