class MailSubscriptionsRepository
  def all
    MailSubscription.all
  end

  def weekly
    active.where(interval: :weekly)
      .where('last_sent_at >= ? OR last_sent_at IS NULL', 7.days.ago)
  end

  def daily
    active.where(interval: :daily)
      .where('last_sent_at >= ? OR last_sent_at IS NULL', 1.day.ago)
  end

  def find_for_user(user)
    all.find_by(user_id: user.id)
  end

  def update(subscription, attrs)
    subscription.assign_attributes(attrs)
    subscription.save
  end

  def active
    all.where(active: true)
  end
end
