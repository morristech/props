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
        # It fails when 2 users have the same amount of props
        desc 'Returns user with the most received props'
        get :hero_of_the_week do
          RankingRepository.new(users_repository, props_repository, "week").hero_of_the_week
        end

        desc 'Returns users in order of received props number'
        params do
          requires :time_range, type: String
        end
        get :top_kudoers do
          RankingRepository.new(users_repository, props_repository, params[:time_range]).top_kudoers
        end
        
        desc 'Returns props count in required time range'
        params do
          requires :time_range, type: String
        end
        get :team_activity do
          RankingRepository.new(users_repository, props_repository, params[:time_range]).team_activity
        end
      end
    end
  end
end
