module Api
  module V1
    module Helpers
      extend Grape::API::Helpers
      include SessionHelpers

      def authenticate_user!
        error!('401 Unauthorized', 401) if current_user.nil?
      end

      def require_api_auth!(token)
        return if current_user.present?
        error!('Invalid token', 401) unless token_valid?(token)
      end

      def token_valid?(token)
        return false if token.nil?
        EasyTokens::Token.exists?(value: token, deactivated_at: nil)
      end
    end
  end
end
