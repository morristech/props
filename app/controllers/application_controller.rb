class ApplicationController < ActionController::Base
  include SessionHelpers

  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private

  def user_signed_in?
    return true if current_membership
  end

  def correct_user?
    @user = User.find(params[:id])
    redirect_to root_url, alert: 'Access denied.' if current_user != @user
  end

  def authenticate_user!
    return if current_membership.present?
    redirect_to root_url, alert: 'You need to sign in for access to this page.'
  end

  def check_domain!
    current = Utils::UrlWithBaseDomain.new(request.url, AppConfig.app_domain)

    if user_signed_in?
      org_subdomain = current_organisation.name
      if current.subdomain != org_subdomain
        redirect_to app_url(host: "#{org_subdomain}.#{AppConfig.app_domain}")
      end
    elsif current.subdomain
      current.subdomain = ''
      redirect_to current.to_s
    end
  end
end
