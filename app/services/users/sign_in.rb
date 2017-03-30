module Users
  class SignIn
    class Success
      attr_reader :user, :organisation

      def initialize(user, organisation)
        @user = user
        @organisation = organisation
      end
    end

    private_constant :Success

    def initialize(auth:,
                   users_repository: UsersRepository.new,
                   organisations_repository: OrganisationsRepository.new)
      @auth = auth
      @users_repository = users_repository
      @organisations_repository = organisations_repository
    end

    def call
      user = @users_repository.user_from_auth(@auth)
      organisation = @organisations_repository.from_auth(@auth)
      organisation.add_user(user)
      Success.new(user, organisation)
    end
  end
end
