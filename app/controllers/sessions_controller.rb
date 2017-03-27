class SessionsController < ApplicationController
  include SessionConcern

  before_action :reset_session, only: [:create, :destroy]
  expose(:users_repository) { UsersRepository.new }

  def new
    redirect_to '/auth/google_oauth2'
  end

  def create
    user = users_repository.user_from_auth(request.env['omniauth.auth'])
    sing_in_user(user)
    if user.email.blank?
      redirect_to edit_user_path(user),
                  alert: 'Please enter your email address.'
    else
      redirect_to app_path, notice: 'Signed in!'
    end
  end

  def destroy
    redirect_to root_url, notice: 'Signed out!'
  end

  def failure(message = nil)
    message ||= params[:message].humanize
    redirect_to root_url, alert: "Authentication error: #{message}",
                          status: :unauthorized
  end
end
