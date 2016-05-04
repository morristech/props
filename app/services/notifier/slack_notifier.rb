class Notifier
  class SlackNotifier < Base
    private

    def notify
      channel.chat_postMessage(message)
    end

    def channel
      @channel ||= Slack.client
    end

    def message
      default_options.merge!(text: notification.to_s)
    end

    def default_options
      {
        channel: AppConfig.slack.default_channel,
        username: 'PropsApp',
        color: '#0092ca',
      }
    end
  end
end
