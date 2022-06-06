class ApplicationController < ActionController::API

  include(Api::AuthorizeRequest)

  rescue_from(StandardError, with: :render_standard_error)
  rescue_from(ActiveRecord::RecordNotFound, with: :render_record_not_found)
  rescue_from(ActiveRecord::RecordInvalid, with: :render_unprocessable_entity)
  rescue_from(Errors::Api::PermissionsError, with: :render_unprocessable_entity)
  rescue_from(Errors::Api::UnauthorizedError, with: :render_unauthorized)

  def render_standard_error(error)
    render(json: { status_code: 500, message: error }, status: :internal_server_error)
  end

  def render_record_not_found(error)
    render(json: { status_code: 404, message: error }, status: :not_found)
  end

  def render_unprocessable_entity(error)
    render(json: { status_code: 422, message: error }, status: :unprocessable_entity)
  end

  def render_unauthorized(error)
    render(json: { status_code: 401, message: error }, status: :unauthorized)
  end

end
