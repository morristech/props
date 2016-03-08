module Api
  module V1
    class Rankings < Grape::API
      include Api::V1::Defaults

      helpers do
        include Api::V1::Helpers

        def props_repository
          PropsRepository.new
        end

        def users_repository
          UsersRepository.new
        end
      end

      before do
        require_api_auth!(params[:token])
      end

      resources :rankings do
        desc 'Return user with the most received props'
        get :hero_of_the_week do
          RankingRepository.new(users_repository, props_repository).hero_of_the_week
        end
      end
    end
  end
end
