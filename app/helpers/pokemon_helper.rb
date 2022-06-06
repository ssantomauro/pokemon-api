module PokemonHelper

  # NOTE: as specified in the model field, I don't know anything about Pokemons world.
  #       I tried to read online something, expecting to find a formula or something similar
  #       to calculate it. But I see there are different theories and honestly a lot of mess around that,
  #       because also the range it's not clear. I'm just using something found on wikipedia
  #       which says that the level should be 1-100.
  #       What I could understand is that on the app/site, when you play, there is a "level" indicator,
  #       some people think there is a formula based on CP, others think is based on IVs values
  #       but I couldn't find consistent information
  def calculate_level(pokemon)
    # Just generating a random number
    rand(1..100)
  end

  def create_details_link(pokemon)
    "/api/pokemons/#{pokemon.id}"
  end

end
