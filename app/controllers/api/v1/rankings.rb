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

        def time_range
          params[:time_range]
        end
      end

      before do
        require_api_auth!(params[:token])
      end

      resources :rankings do
        desc 'Returns user with the most received props'
        get :hero_of_the_week do
          RankingRepository.new(users_repository, props_repository, 'weekly').hero_of_the_week
        end

        desc 'Returns users in order of received props number'
        params do
          requires :time_range, type: String
        end
        get :top_kudoers do
          RankingRepository.new(users_repository, props_repository, time_range).top_kudoers
        end

        desc 'Returns props count in required time range'
        params do
          requires :time_range, type: String
        end
        get :team_activity do
          RankingRepository.new(users_repository, props_repository, time_range).team_activity
        end

        desc 'Returns users with kudos streak'
        params do
          requires :time_range, type: String
        end
        get :kudos_streak do
          RankingRepository.new(users_repository, props_repository, time_range).kudos_streak
        end
      end
    end
  end
end
