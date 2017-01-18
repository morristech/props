module Api
  module V1
    class Sessions < Grape::API
      include Api::V1::Defaults

      helpers do
        include Api::V1::Helpers
      end

      resources :sessions do
        desc 'Get current user for given uid if exists'
        params do
          requires :uid, type: String, desc: 'User Google id'
        end
        get do
          user = User.find_by(uid: params.uid)
          error!({ error: 'User not found' }, 404) if user.nil?
          present user, with: Entities::UserBase
        end

        desc 'Create or restore session'
        params do
          requires :uid, type: String, desc: 'User Google id'
          requires :email, type: String, desc: 'Account email'
          requires :name, type: String, desc: 'Google user anme'
        end
        post do
          user = User.find_or_create_by(uid: params.uid)
          user.update_attributes(params.except(:uid))
          present user, with: Entities::UserBase
        end
      end
    end
  end
end
