Slack.configure do |config|
  config.token = AppConfig.slack.token
end

Thread.new do
  SlackBot.new.listen
end
