module Api
  class PokemonsController < ApplicationController
    include(PokemonHelper)

    before_action(:authenticate_user!)

    def index
      page = (strong_params[:page] || '1').to_i
      per_page = (strong_params[:per_page] || '20').to_i
      category = strong_params[:category]

      pokemons = Pokemon.page(page).per(per_page)
      pokemons = pokemons.where(category: category) if category.present?

      pokemons_json = {
        count: pokemons.total_count,
        page: page,
        per_page: per_page,
        results: ActiveModel::SerializableResource.new(pokemons, each_serializer: PokemonListItemSerializer).as_json
      }

      render(json: pokemons_json)
    end

    # NOTE: I'm not 100% sure this is what you requested (I mean to have the same endpoint with 2 different input types)
    def show
      pokemon =
        strong_params[:pokemon_id] ?
          Pokemon.find(strong_params[:pokemon_id]) :
          Pokemon.find_by_name!(strong_params[:pokemon_name])

      render(json: pokemon)
    end

    def capture
      pokemon =
        strong_params[:pokemon_id] ?
          Pokemon.find(strong_params[:pokemon_id]) :
          Pokemon.find_by_name!(strong_params[:pokemon_name])

      level = calculate_level(pokemon)
      capture = current_user.captures.create!(pokemon: pokemon, level: level, nickname: strong_params[:nickname])

      # I'm using the HTTP code 200 and not the 201 because we don't have a `capture#show` for this API,
      # thus it doesn't make sense sending the `/api/captures/:id` url into the `Location` header with HTTP 201
      # (which is the suggested behavior when it creates a new resource)
      render(json: capture, status: :ok)
    end

    private

    def strong_params
      @strong_params ||= params.permit(:pokemon_id, :pokemon_name, :page, :per_page, :nickname, :category)
    end
  end
end
