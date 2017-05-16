module Api
  module V1
    class Slack < Grape::API
      include Api::V1::Defaults
      helpers do
        include Api::V1::Helpers

        def prop_params(params)
          params.merge(propser_id: current_user.id, organisation_id: current_organisation.id)
        end

        def props_repository
          PropsRepository.new
        end
      end

      # before do
      #   require_api_auth!(params[:token])
      # end

      resources :slack do
        desc 'Create new props from slack command'
        params do
          requires :token, type: String
          requires :team_id, type: String
          requires :user_id, type: String
          requires :command, type: String
          requires :text, type: String
        end

        post :create_prop do
          ::Slack::CreateProp.new(params).call
        end
      end
    end
  end
end
