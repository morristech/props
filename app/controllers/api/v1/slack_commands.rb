module Api
  module V1
    class SlackCommands < Grape::API
      include Api::V1::Defaults
      helpers do
        include Api::V1::Helpers
      end

      before do
        require_api_auth!(params[:token])
      end

      resources :slack_commands do
        desc 'Create new props from slack command'
        params do
          requires :token, type: String
          requires :team_id, type: String
          requires :user_id, type: String
          requires :command, type: String
          requires :text, type: String
        end

        post :kudos do
          ::SlackCommands::CreateProp.new(params).call
        end
      end
    end
  end
end
