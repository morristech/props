Slack::RealTime.configure do |config|
  # config.token = AppConfig.slack.token
  # config.concurrency = Slack::RealTime::Concurrency::Celluloid
end

if defined? Rails::Server
  Thread.new do
    SlackBot.new.listen
  end
end
