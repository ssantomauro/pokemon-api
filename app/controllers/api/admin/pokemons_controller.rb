module Api
  module Admin
    class PokemonsController < ApplicationController
      include(PokemonHelper)

      PERMITTED_ROLES = %w[admin]

      before_action(:authorize!)

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

      def strong_params
        @strong_params ||= params.permit(:name, :weight, :height, :sprite_url)
      end
    end
  end
end
