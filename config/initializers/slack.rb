require 'slack'

if AppConfig.slack.token.present?
  Slack.configure do |config|
    config.token = AppConfig.slack.token
  end
  Slack.auth_test
end
