module Api
  class PokemonsController < ApplicationController
    include(PokemonHelper)

    before_action(:authenticate_user!)

    api(:GET, '/api/pokemons', 'List all pokemons')
    param(:category, String, desc: 'Only return Pokemons for the given category')
    param(:page, Numeric, desc: 'A cursor for pagination across multiple pages of results. The default is 1.')
    param(:per_page, Numeric, desc: 'A limit on the number of objects to be returned. The default is 10.')
    returns(desc: 'Returns a list of Pokemon objects if the request is valid, and returns an error otherwise.')
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

    api(:GET, '/api/pokemons/:pokemon_id|:pokemon_name', 'Retrieves the Pokemon with the given ID or Name.')
    param(:pokemon_id, Numeric, desc: 'This is the Pokemon ID you want to show the details')
    param(:pokemon_name, String, desc: 'This is the Pokemon name you want to show the details')
    returns(desc: 'Returns a Pokemon if a valid ID or name was provided. Returns an error otherwise.')
    # NOTE: I'm not 100% sure this is what you requested (I mean to have the same endpoint with 2 different input types)
    def show
      pokemon =
        strong_params[:pokemon_id] ?
          Pokemon.find(strong_params[:pokemon_id]) :
          Pokemon.find_by_name!(strong_params[:pokemon_name])

      render(json: pokemon)
    end

    api(:POST, '/api/pokemons/:pokemon_id|:pokemon_name/capture', 'Saves the capture by the User for a given Pokemon ID or Name')
    param(:pokemon_id, Numeric, desc: 'This is the Pokemon ID you want to capture')
    param(:pokemon_name, String, desc: 'This is the Pokemon name you want to capture')
    returns(desc: 'Returns a Pokemon if the request is valid. Returns an error otherwise.')
    def capture
      pokemon =
        strong_params[:pokemon_id] ?
          Pokemon.find(strong_params[:pokemon_id]) :
          Pokemon.find_by_name!(strong_params[:pokemon_name])

      level = calculate_level(pokemon)
      capture = current_user.captures.create!(pokemon: pokemon, level: level, nickname: strong_params[:nickname])

      # I'm using the HTTP code 200 and not the 201 because we don't have a `capture#show` for this API,
      # thus it doesn't make sense sending the `/api/captures/:id` url into the `Location` header with HTTP 201
      # (which is the suggested behavior for the creation of a new resource)
      render(json: capture, status: :ok)
    end

    private

    # Not necessary because I'm passing each single param to the Models.
    def strong_params
      @strong_params ||= params.permit(:pokemon_id, :pokemon_name, :page, :per_page, :nickname, :category)
    end
  end
end
