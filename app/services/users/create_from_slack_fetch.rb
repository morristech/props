module Users
  class CreateFromSlackFetch

    def call(user_info)
      user = slack_user(user_info)
      return Users::ArchiveUser.new(user).call if user.present? && deleted?(user_info)
      return update_with_slack_fetch(user_info) if user.present?
      User.create! slack_fetch_attrs(user_info)
    end

    private

    def update_with_slack_fetch(user_info)
      slack_user(user_info).tap do |user|
        user.update slack_fetch_attrs(user_info)
      end
    end

    def slack_user(user_info)
      User.find_by(uid: user_info['id']) || User.find_by(email: user_info['profile']['email'])
    end

    def deleted?(user_info)
      user_info['deleted']
    end

    def slack_fetch_attrs(user_info)
      {
        provider: 'slack',
        uid: user_info['id'],
        name: name_from_user_info(user_info),
        email: user_info['profile']['email'] || '',
        admin: user_info['is_admin'] || false,
        avatar: user_info['profile']['image_512'],
        archived_at: nil,
      }
    end

    def name_from_user_info(user_info)
      user_info['real_name'].blank? ? user_info['name'] : user_info['real_name']
    end
  end
end
