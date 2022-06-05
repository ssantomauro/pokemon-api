# frozen_string_literal: true

module Api
  class PokemonsController < ApplicationController

    before_action(:authenticate_user!)

    def index
      page = (strong_params[:page] || '1').to_i
      per_page = (strong_params[:per_page] || '20').to_i
      pokemons = Pokemon.page(page).per(per_page)

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
          Pokemon.find_by_id(strong_params[:pokemon_id]) :
          Pokemon.find_by_name(strong_params[:pokemon_name])
      return render(status: :not_found) if pokemon.nil?

      render(json: pokemon)
    end

    private

    def strong_params
      @strong_params ||= params.permit(:pokemon_id, :pokemon_name, :page, :per_page)
    end
  end
end
