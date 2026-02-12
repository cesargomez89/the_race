class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotUnique, with: :render_conflict
  rescue_from ActionController::ParameterMissing, with: :render_bad_request

  private

  def render_not_found(_exception)
    render_error("not_found", "Resource not found", :not_found)
  end

  def render_unprocessable_entity(exception)
    render json: {
      error: {
        code: "validation_failed",
        message: "Validation failed",
        details: exception.record.errors.to_hash(true)
      }
    }, status: :unprocessable_entity
  end

  # This only happens when we don't validate the model correctly
  # :nocov:
  def render_conflict(_exception)
    render_error("conflict", "Resource already exists", :conflict)
  end
  # :nocov:

  def render_bad_request(exception)
    render_error("bad_request", exception.message, :bad_request)
  end

  def render_error(code, message, status)
    render json: {
      error: {
        code: code,
        message: message
      }
    }, status: status
  end
end
