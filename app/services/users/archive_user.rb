module Users
  class ArchiveUser
    pattr_initialize [:user!]

    def call
      user.archived_at = Time.current
      user.save!
      remove_mail_subscription!
    end

    private

    def remove_mail_subscription!
      repo = MailSubscriptionsRepository.new
      sub = repo.find_for_user(user)
      sub.update_column(:active, false) if sub.present?
    end
  end
end
