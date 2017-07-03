module Users
  class CreateFromSlackFetch
    pattr_initialize [:user_info!]

    def call
      return Users::ArchiveUser.new(slack_user).call if slack_user.present? && deleted?
      return update_with_slack_fetch if slack_user.present?
      User.create! slack_fetch_attrs
    end

    private

    def update_with_slack_fetch
      slack_user.tap do |user|
        user.update slack_fetch_attrs
      end
    end

    def slack_user
      @slack_user ||= User.find_by(uid: user_info['id']) ||
                      User.find_by(email: user_info['profile']['email'])
    end

    def deleted?
      user_info['deleted']
    end

    def slack_fetch_attrs
      {
        provider: 'slack',
        uid: user_info['id'],
        name: name_from_user_info,
        email: user_info['profile']['email'] || '',
        admin: user_info['is_admin'] || false,
        avatar: user_info['profile']['image_512'],
        archived_at: nil,
      }
    end

    def name_from_user_info
      user_info['real_name'].presence || user_info['name']
    end
  end
end
