module Users
  class SignIn
    class Success
      attr_reader :membership

      def initialize(membership)
        @membership = membership
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
      email = @auth['info']['email']
      user.update_attributes(email: email) unless user.email == email
      organisation = @organisations_repository.from_auth(@auth)
      organisation.add_user(user)
      membership = Membership.where(user: user, organisation: organisation).first
      Success.new(membership)
    end
  end
end
