# frozen_string_literal: true

LOGRAGE_EXCEPTIONS = %w[controller action format id].freeze

Rails.application.configure do
  config.lograge.enabled = true

  config.lograge.keep_original_rails_log = false
  config.lograge.logger = ActiveSupport::Logger.new($stdout)

  # Set the default log formatter but only if we have Lograge
  # enabled since we are using the Lograge JSON formatter.
  if config.lograge.enabled
    config.log_formatter = Lograge::Formatters::Logstash.new
    config.lograge.formatter = config.log_formatter
  end

  config.lograge.custom_options = lambda do |event|
    {
      request_id: event.payload[:request_id],
      request_ip: event.payload[:ip],
      user_agent: event.payload[:user_agent],
      request_method: event.payload[:method],
      request_path: event.payload[:path],
      response_status: event.payload[:status],
      response_time: event.duration.round(2),
      params: event.payload[:params].except(*LOGRAGE_EXCEPTIONS)
    }.compact_blank!
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
