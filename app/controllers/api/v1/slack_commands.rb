module Api
  module V1
    class SlackCommands < Grape::API
      include Api::V1::Defaults
      helpers do
        include Api::V1::Helpers

        PERMITED_BOT = 'Slackbot 1.0 (+https://api.slack.com/robots)'.freeze

        def permited_bot?
          request.user_agent.include?(PERMITED_BOT)
        end

        def wrong_user_agent_message
          { text: I18n.t('slack_commands.kudos.errors.wrong_user_agent') }
        end
      end

      before do
        require_api_auth!(params[:token])
      end

      namespace :slack_commands do
        desc 'Create new prop from /kudos slack command'
        params do
          requires :token, type: String
          requires :team_id, type: String
          requires :user_id, type: String
          requires :command, type: String
          requires :text, type: String
        end

        post :kudos do
          return wrong_user_agent_message unless permited_bot?
          return unless params[:command] == '/kudos' || params[:command] == '/kudos_stg'
          ::SlackCommands::Kudos.new(params).call
        end
      end
    end
  end
end
