module Api
  module Admin
    class PokemonsController < ApplicationController
      include(PokemonHelper)

      PERMITTED_ROLES = %w[admin]

      before_action(:authorize!)

      api(:POST, '/api/admin/pokemons', 'Creates a new Pokemon with category `custom`')
      param(:name, String, desc: "The Pokemon's name")
      param(:weight, Numeric, desc: "The Pokemon's weight")
      param(:height, Numeric, desc: "The Pokemon's height")
      param(:sprite_url, String, desc: "The Pokemon's URL sprite")
      returns(code: 201, desc: 'Returns an empty response with the Pokemon Details URL into the `Location` Header.')
      def create
        pokemon =
          Pokemon.create!(
            name: strong_params[:name],
            weight: strong_params[:weight],
            height: strong_params[:height],
            sprite_url: strong_params[:sprite_url],
            category: 'custom'
          )

        response.set_header('Location', create_details_link(pokemon))
        render(status: :created)
      end

      private

      # Not necessary because I'm passing each single param to the Models.
      def strong_params
        @strong_params ||= params.permit(:name, :weight, :height, :sprite_url)
      end
    end
  end
end
