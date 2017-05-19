class SettingsController < AuthenticatedController
  expose(:mail_subscription) do
    subscriptions_repo.find_for_user(current_user) ||
      MailSubscription.new
  end
  expose(:organisation) { current_organisation }
  expose(:subscriptions_repo) { MailSubscriptionsRepository.new }

  def index
  end

  def apply
    subscriptions_repo.update(mail_subscription, subscription_attributes)
    redirect_to action: :index
  end

  def save_slack_channel
    organisation.update(organisation_attributes) if current_user.admin?
    redirect_to action: :index
  end

  private

  def organisation_attributes
    params.require(:organisation)
          .permit(:slack_channel)
  end

  def subscription_attributes
    params.require(:mail_subscription)
          .permit(:active, :interval)
          .merge(user_id: current_user.id)
  end
end
