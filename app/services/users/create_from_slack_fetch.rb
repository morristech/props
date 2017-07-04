module Users
  class CreateFromSlackFetch
    pattr_initialize [:user_info!]

    def call
      return update_with_slack_fetch if slack_user.present?
      User.create! slack_fetch_attrs
    end

    private

    def update_with_slack_fetch
      slack_user.update slack_fetch_attrs
      manage_archivisation
    end

    def slack_user
      @slack_user ||= User.find_by(uid: user_info['id']) ||
                      User.find_by(email: user_info['profile']['email'])
    end

    def manage_archivisation
      return Users::ArchiveUser.new(user: slack_user).call if to_archive?
      Users::UnarchiveUser.new(user: slack_user).call if to_unarchive?
    end

    def to_archive?
      !slack_user.archived_at? && deleted_from_slack?
    end

    def to_unarchive?
      slack_user.archived_at? && !deleted_from_slack?
    end

    def deleted_from_slack?
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
      }
    end

    def name_from_user_info
      user_info['real_name'].presence || user_info['name']
    end
  end
end
