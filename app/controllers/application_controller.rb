class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private

  def current_user
    @current_user ||= session_user || api_user
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.find(params[:id])
    redirect_to root_url, alert: 'Access denied.' if current_user != @user
  end

  def authenticate_user!
    return if current_user.present?
    redirect_to root_url, alert: 'You need to sign in for access to this page.'
  end

  def api_user
    EasyTokens::Token.find_by(value: params[:api_key], deactivated_at: nil).try(:owner)
  end

  def session_user
    User.find_by(id: env['rack.session'][:user_id])
  end
end
