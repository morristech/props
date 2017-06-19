module Users
  class DownloadUsers
    def call
      fetch_users_from_every_organisation
    end

    private

    def fetch_users_from_every_organisation
      Organisation.all.each do |organisation|
        create_or_update_users(organisation)
      end
    end

    def create_or_update_users(organisation)
      users_array(organisation).each do |user_info|
        next if bot?(user_info)
        puts user_info['name']
        user = users_repository.user_from_slack_fetch(user_info)
        organisation.add_user(user)
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

    def bot?(user_info)
      user_info.is_bot? || user_info.name.inquiry.slackbot?
    end
  end
end
