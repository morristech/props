module Api
  class UsersController < AuthenticatedController
    expose(:users_repository) { UsersRepository.new }

    def index
      render json: users_repository.active,
             each_serializer: UserSerializer::Base
    end

    def show
      user = users_repository.find_by_id(params[:id])
      render json: user, serializer: UserSerializer::Full
    end
  end
end
