# frozen_string_literal: true

class ApplicationController < ActionController::Base # :nodoc:
  rescue_from Exception, with: :handle_internal_server_error

  private

  def handle_internal_server_error(exception)
    Rails.logger.debug { exception.inspect }

    # Log the exception or perform any necessary actions
    # You can also render a custom error page if desired
    render plain: '500 Internal Server Error', status: :internal_server_error
  end
end
