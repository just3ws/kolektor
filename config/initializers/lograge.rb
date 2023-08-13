# frozen_string_literal: true

LOGRAGE_EXCEPTIONS = %w[controller action format id].freeze

Rails.application.configure do
  config.enabled = true
  config.formatter = Lograge::Formatters::Logstash.new
  config.custom_options = lambda do |event|
    {
      params: event.payload[:params].except(*LOGRAGE_EXCEPTIONS)
    }
  end
end

# {
#   request_id: event.payload[:request_id],
#   request_ip: event.payload[:ip],
#   user_agent: event.payload[:user_agent],
#   request_method: event.payload[:method],
#   request_path: event.payload[:path],
#   response_status: event.payload[:status],
#   response_time: event.duration.round(2)
# }
