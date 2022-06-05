class Pokemon < ApplicationRecord

  # It is not important this default order, but I've added it just because of the pagination.
  # Even if the default order by ID should be fine, I preferred define an order by creation time
  default_scope { order(:created_at) }

  # In this case I could use the `has_and_belongs_to_many` because the exercise
  # doesn't use the relation (it is used only as association table).
  # However I used this way because in my experience is the more flexible way
  # if in the future the association table can become more complex or need validations.
  has_many(:pokemons_types, dependent: :destroy)
  has_many(:types, through: :pokemons_types)

  validates_presence_of(:name, :weight, :height, :sprite_url)

  # This is a simple regex I've used in other projects, but should me customized based on the real possible inputs
  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates(:sprite_url, format: { with: URL_REGEXP, message: 'wrong format.' })

  # I don't have the Pokemon API specification but I suppose this should be
  # unique, so I'm adding this validation and relative DB table constraint
  validates_uniqueness_of(:name)

end
