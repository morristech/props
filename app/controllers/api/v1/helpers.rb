module Api
  module V1
    module Helpers
      extend Grape::API::Helpers
      def current_user
        @current_user ||= User.find(session_user_id) if session_user_id
      end

      def authenticate_user!
        error!('401 Unauthorized', 401) unless current_user.present?
      end

      def require_api_auth!(token)
        return if current_user.present?
        error!('Invalid token', 401) unless token_valid?(token)
      end

      def token_valid?(token)
        return false if token.nil?
        EasyTokens::Token.exists?(value: token, deactivated_at: nil)
      end

      def session_user_id
        env['rack.session'][:user_id]
      end
    end
  end
end
