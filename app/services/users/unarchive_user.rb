module Users
  class UnarchiveUser
    pattr_initialize [:user!]

    def call
      user.archived_at = nil
      user.save!
      restore_mail_subscription!
      user
    end

    private

    def restore_mail_subscription!
      repo = MailSubscriptionsRepository.new
      sub = repo.find_for_user(user)
      sub.update_column(:active, true) if sub.present?
    end
  end
end
