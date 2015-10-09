module EmailDigests
  class CreateSubscriptions
    def call
      Rails.logger.tagged('Email Digest') do |logger|
        user_without_subscription_ids.each do |user_id|
          MailSubscription.create!(user_id: user_id)
          logger.info "Mail subscription created for User##{user_id}"
        end
      end
    end

    private

    def user_without_subscription_ids
      user_ids - user_ids_from_subscriptions
    end

    def user_ids
      User.where(archived_at: nil).pluck(:id)
    end

    def user_ids_from_subscriptions
      MailSubscription.pluck(:user_id)
    end
  end
end
