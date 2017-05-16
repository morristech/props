module Slack
  class CreateProp
    attr_reader :propser, :organisation, :users, :text

    def initialize(params)
      @propser = find_user_by_uid(params[:user_id])
      @organisation = find_organisation_by_team_id(params[:team_id])
      @users = find_users_in_text(params[:text])
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

    def find_users_in_text(text)
      regex = /<@([a-zA-z0-9]*)\|[a-zA-z0-9]*>/
      if text.scan(regex).any?
        users = text.scan(regex).flatten

        results = []
        users.each do |user|
          results << User.find_by(uid: user)
        end
        results
      else
        []
      end
    end

    def remove_users_from_text(text)
      regex = /<@([a-zA-z0-9]*)\|[a-zA-z0-9]*>/
      text.gsub(regex, '')
    end
  end
end
