module SlackCommands
  class Kudos
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
      return message(I18n.t('slack_commands.kudos.help')) if need_help?
      return message(I18n.t('slack_commands.kudos.errors.prop_receivers_missing')) if users.empty?
      return message(I18n.t('slack_commands.kudos.errors.selfpropsing')) if selfpropsing?
      return message(I18n.t('slack_commands.kudos.errors.params_missing')) if missing_params?

      save_prop
    end

    private

    def save_prop
      prop = Prop.new(propser_id: propser.id, body: text, organisation_id: organisation.id)

      users.each do |user|
        prop.prop_receivers.build(user_id: user.id)
      end

      if prop.save
        send_notification(prop)
        message(I18n.t('slack_commands.kudos.messages.created'))
      else
        message(I18n.t('slack_commands.kudos.errors.not_created'))
      end
    end

    def selfpropsing?
      users.include?(propser)
    end

    def missing_params?
      propser.nil? || organisation.nil? || text.nil?
    end

    def message(message)
      { text: message }
    end

    def find_user_by_uid(uid)
      User.find_by(uid: uid)
    end

    def find_organisation_by_team_id(team_id)
      Organisation.find_by(team_id: team_id)
    end

    def find_users_from_text(text)
      return [] if text.scan(USER_SLACK_REGEX).empty?

      user_ids = text.scan(USER_SLACK_REGEX).flatten.uniq
      users = []
      user_ids.each do |user_id|
        next unless User.exists?(uid: user_id)
        users << User.find_by(uid: user_id)
      end
      users
    end

    def remove_users_from_text(text)
      text.gsub(USER_SLACK_REGEX, '').strip
    end

    def send_notification(prop)
      ::NotifierJob.perform_later prop.id
    end

    def need_help?
      text == 'help'
    end
  end
end
