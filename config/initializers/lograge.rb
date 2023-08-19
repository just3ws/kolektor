# frozen_string_literal: true

Rails.application.configure do
  config.lograge.enabled = true

  config.lograge.keep_original_rails_log = true
  # config.lograge.logger = ActiveSupport::Logger.new($stdout)
  config.lograge.logger = Appsignal::Logger.new('rails', format: Appsignal::Logger::LOGFMT)

  # Set the default log formatter but only if we have Lograge
  # enabled since we are using the Lograge JSON formatter.
  if config.lograge.enabled
    config.log_formatter = Lograge::Formatters::Logstash.new
    config.lograge.formatter = config.log_formatter
  end

  config.lograge.custom_options = lambda do |event|
    {
      request_ip: event.payload[:ip],
      user_agent: event.payload[:user_agent],
      request_method: event.payload[:method],
      request_path: event.payload[:path],
      response_status: event.payload[:status],
      response_time: event.duration.round(2),
      params: event.payload[:params].except('controller', 'actions')
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
