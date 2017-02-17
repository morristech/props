module SessionsServices
  class Authorizer
    def initialize(user)
      @user = user
      @uid = user['provider'] + '|' + user['uid']
    end

    attr_reader :user, :uid

    def call(fields = 'email,identities')
      auth0_params = {
        client_id: AppConfig.auth0_api_client_id,
        domain: AppConfig.auth0_domain,
        token: '',
        api_version: 2,
      }

      auth0_params['token'] = Auth0Client.new(auth0_params).obtain_access_token

      auth0 = Auth0Client.new(auth0_params)
      auth0_user = auth0.user(uid, fields: fields)
      user_authorized?(auth0_user)
    end

    def user_authorized?(auth0_user)
      auth0_user['email'] == user['info']['email'] &&
        auth0_user['identities'][0]['user_id'] == user.uid
    end
  end
end
