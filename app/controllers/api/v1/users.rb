module Api
  module V1
    class Users < Grape::API
      include Api::V1::Defaults

      helpers do
        include Api::V1::Helpers

        def users_repository
          UsersRepository.new
        end
      end

      before do
        authenticate_user!
      end

      resources :users do
        desc 'Returns all active users'
        get do
          users = policy_scope(User)
          present users, with: Entities::UserBase
        end

        namespace ':user_id' do
          desc 'Returns specific user'
          params do
            requires :user_id, type: Integer
          end
          get do
            user = users_repository.find_by_id(params[:user_id])
            authorize user, :show?
            present user, with: Entities::UserFull
          end
        end
      end
    end
  end
end
