module Auth0
  module Api
    module AuthenticationEndpoints
      def obtain_access_token
        request_params = {
          client_id: AppConfig.auth0_api_client_id,
          client_secret: AppConfig.auth0_api_client_secret,
          audience: AppConfig.auth0_api_audience,
          grant_type: 'client_credentials',
        }

        post('/oauth/token', request_params)['access_token']
      end
    end
  end
end
