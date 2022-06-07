module Api
  class CapturesController < ApplicationController

    before_action(:authenticate_user!)

    api(:GET, '/api/captures', 'List all the captures for the logged in user')
    param(:page, Numeric, desc: 'A cursor for pagination across multiple pages of results. The default is 1.')
    param(:per_page, Numeric, desc: 'A limit on the number of objects to be returned. The default is 10.')
    returns(desc: 'Returns a list of Capture objects if the request is valid, and returns an error otherwise.')
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

    # Not necessary because I'm passing each single param to the Models.
    def strong_params
      @strong_params ||= params.permit(:pokemon_id, :pokemon_name, :page, :per_page, :nickname)
    end
  end
end
