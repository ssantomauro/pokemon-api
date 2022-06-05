module Api
  class CapturesController < ApplicationController

    before_action(:authenticate_user!)

    def index
      page = (strong_params[:page] || '1').to_i
      per_page = (strong_params[:per_page] || '20').to_i
      captures = current_user.captures.page(page).per(per_page)

      captures_json = {
        count: captures.total_count,
        page: page,
        per_page: per_page,
        results: ActiveModel::SerializableResource.new(captures).as_json
      }

      render(json: captures_json)
    end

    private

    def strong_params
      @strong_params ||= params.permit(:pokemon_id, :pokemon_name, :page, :per_page, :nickname)
    end
  end
end
