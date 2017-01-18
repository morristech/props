module Api
  module V1
    module Helpers
      extend Grape::API::Helpers
      def current_user
        @current_user ||= session_user || api_user
      end

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

      def api_user
        EasyTokens::Token.find_by(value: params[:api_key], deactivated_at: nil).try(:owner)
      end

      def session_user
        User.find_by(id: env['rack.session'][:user_id]) || User.find_by(uid: headers['Google-Id'])
      end
    end
  end
end
