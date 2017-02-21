module Api
  module V1
    class Sessions < Grape::API
      include Api::V1::Defaults
      helpers do
        include Api::V1::Helpers
      end

      resources :sessions do
        desc 'Restore session from token'
        params do
          requires :uid, type: String, desc: 'User Google id'
        end
        get do
          data = declared(params)
          user = User.find_by(uid: data.uid)
          error!({ error: 'User not found' }, 404) if user.nil?
          present user, with: Entities::UserBase
        end

        desc 'Create or restore session'
        params do
          requires :uid, type: String, desc: 'User UID'
          requires :provider, type: String, desc: 'Auth provider'
          requires :info, type: Hash do
            requires :email, type: String, desc: 'User email'
            requires :name, type: String, desc: 'User name'
          end
        end

        post do
          data = declared(params)
          return error!({ error: 'User not authorized' }, 404) unless
            SessionsServices::Authorizer.new(data).call

          user = User.create_with_omniauth(data)
          present user, with: Entities::UserBase
        end
      end
    end
  end
end
