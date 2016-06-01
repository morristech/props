class Notifier
  class SlackNotifier < Base
    private

    def notify
      response = channel.chat_postMessage(message)
      notification.prop.update(slack_ts: response[:ts])

    rescue Slack::Web::Api::Error => err
      Rails.logger.error "Sending slack notifaction failed. Reason: #{err}"
    end

    def channel
      @channel ||= Slack::RealTime::Client.new.web_client
    end

    def message
      default_options.merge!(text: notification.to_s)
    end

    def icon
      %w(:beers: :ok_hand:).sample
    end

    def default_options
      {
        channel: AppConfig.slack.default_channel,
        username: 'PropsApp',
        color: '#0092ca',
        icon_emoji: icon,
      }
    end
  end
end
