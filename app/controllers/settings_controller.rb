class SettingsController < AuthenticatedController
  expose(:mail_subscription) do
    subscriptions_repo.find_for_user(current_user) ||
      MailSubscription.new
  end
  expose(:subscriptions_repo) { MailSubscriptionsRepository.new }

  def index
  end

  def apply
    subscriptions_repo.update(mail_subscription, subscription_attributes)
    redirect_to action: :index
  end

  private

  def subscription_attributes
    params.require(:mail_subscription)
          .permit(:active, :interval)
          .merge(user_id: current_user.id)
  end
end
