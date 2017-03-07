require 'rollbar/rails'
Rollbar.configure do |config|
  config.access_token = AppConfig.rollbar_access_token
  config.exception_level_filters["ActionController::RoutingError"] = "ignore"
  if %w(development test).include?(Rails.env)
    config.enabled = false
  end
end
