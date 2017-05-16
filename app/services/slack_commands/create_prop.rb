module SlackCommands
  class CreateProp
    USER_SLACK_REGEX = /<@([a-zA-z0-9]*)\|[a-zA-z0-9]*>/
    private_constant :USER_SLACK_REGEX

    attr_reader :propser, :organisation, :users, :text

    def initialize(params)
      @propser = find_user_by_uid(params[:user_id])
      @organisation = find_organisation_by_team_id(params[:team_id])
      @users = find_users_from_text(params[:text])
      @text = remove_users_from_text(params[:text])
    end

    def call
      prop = Prop.new(propser_id: propser.id, body: text, organisation_id: organisation.id)

      users.each do |user|
        prop.prop_receivers.build(user_id: user.id)
      end

      if prop.save
        { text: I18n.t('slack.messages.props_created') }
      else
        { text: I18n.t('slack.messages.props_not_created') }
      end
    end

    def find_user_by_uid(uid)
      User.find_by(uid: uid)
    end

    def find_organisation_by_team_id(team_id)
      Organisation.find_by(team_id: team_id)
    end

    def find_users_from_text(text)
      return [] if text.scan(USER_SLACK_REGEX).empty?

      user_ids = text.scan(USER_SLACK_REGEX).flatten
      users = []
      user_ids.each do |user_id|
        users << User.find_by(uid: user_id)
      end
      users
    end

    def remove_users_from_text(text)
      text.gsub(USER_SLACK_REGEX, '')
    end
  end
end
