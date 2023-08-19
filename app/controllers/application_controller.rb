# frozen_string_literal: true

class ApplicationController < ActionController::Base # :nodoc:
  rescue_from Exception, with: :handle_internal_server_error

  def index
    respond_to(&:html)
  end

  def append_info_to_payload(payload)
    super

    payload[:host] = request.host
    payload[:request_id] = request.uuid
    payload[:user_id] = current_user.id if current_user
    payload[:x_forwarded_for] = request.env['HTTP_X_FORWARDED_FOR']
  end

  def current_user
    @current_user ||= { id: 0 }
  end

  private

  def handle_internal_server_error(exception)
    Rails.logger.debug { exception.inspect }

    # Log the exception or perform any necessary actions
    # You can also render a custom error page if desired
    render plain: '500 Internal Server Error', status: :internal_server_error
  end
end
