class Notifier
  pattr_initialize :notification, [:options]

  def call
    enabled_notifications.each do |notification|
      send("notify_#{notification}")
    end
  end

  private

  def notify_slack
    Notifier::SlackNotifier.new(notification, options).call
  end

  def notify_mobile
    Notifier::MobileNotifier.new(notification, options).call
  end

  def enabled_notifications
    %w(mobile)
  end
end
