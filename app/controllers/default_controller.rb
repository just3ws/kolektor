# frozen_string_literal: true

class DefaultController < ActionController::Base # :nodoc:
  rescue_from Exception, with: :handle_internal_server_error

  def index
    respond_to(&:html)
  end
end
