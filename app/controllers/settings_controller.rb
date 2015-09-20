class SettingsController < AuthenticatedController
  expose(:mail_subscription) { MailSubscription.new }

  def index
  end

  def apply
  end
end
