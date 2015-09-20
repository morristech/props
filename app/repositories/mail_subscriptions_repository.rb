class MailSubscriptionsRepository
  def find_for_user(user)
    MailSubscription.find_by(user_id: user.id)
  end

  def update(subscription, attrs)
    subscription.assign_attributes(attrs)
    subscription.save
  end
end
