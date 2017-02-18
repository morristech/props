module SessionsServices
  class Authorizer
    def initialize(user)
      @user = user
      @uid = user['provider'] + '|' + user['uid']
      @auth0_params = {
        client_id: AppConfig.auth0_api_client_id,
        domain: AppConfig.auth0_domain,
        token: '',
        api_version: 2,
      }
    end

    attr_reader :user, :uid, :auth0_params

    def call(fields = 'email,identities')
      auth0_params[:token] = obtain_grant_token
      auth0_user = Auth0Client.new(auth0_params).user(uid, fields: fields)

      user_authorized?(auth0_user)
    end

    def user_authorized?(auth0_user)
      auth0_user['email'] == user['info']['email'] &&
        auth0_user['identities'][0]['user_id'] == user.uid
    end

    def obtain_grant_token
      Auth0Client.new(auth0_params).obtain_access_token
    end
  end
end
