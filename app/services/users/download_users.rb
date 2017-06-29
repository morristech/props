module Users
  class DownloadUsers
    vattr_initialize [:organisation!]

    def call
      create_or_update_users(organisation)
    end

    private

    def create_or_update_users(organisation)
      users_array(organisation).each do |user_info|
        next if invalid_user?(user_info)
        user = users_repository.user_from_slack_fetch(user_info)
        organisation.add_user(user) if user.present?
      end
    end

    def users_array(organisation)
      token = token(organisation)
      client(token).users_list.members
    end

    def token(organisation)
      organisation.token
    end

    def client(token)
      Slack::RealTime::Client.new(token: token).web_client
    end

    def users_repository
      @users_repository ||= UsersRepository.new
    end

    def invalid_user?(user_info)
      user_info['is_bot'] ||
        user_info['name'].inquiry.slackbot? ||
        user_info['profile']['guest_channels'].present? ||
        user_info['is_restricted'] ||
        user_info['is_ultra_restricted']
    end
  end
end
