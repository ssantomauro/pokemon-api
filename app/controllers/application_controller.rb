class ApplicationController < ActionController::API

  rescue_from(StandardError, with: :render_standard_error)
  rescue_from(ActiveRecord::RecordNotFound, with: :render_record_not_found)
  rescue_from(ActiveRecord::RecordInvalid, with: :render_record_invalid)

  def render_standard_error(error)
    render(json: { status_code: 500, message: error }, status: :internal_server_error)
  end

  def render_record_not_found(error)
    render(json: { status_code: 404, message: error }, status: :not_found)
  end

  def render_record_invalid(error)
    render(json: { status_code: 422, message: error }, status: :unprocessable_entity)
  end

end
