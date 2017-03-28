class SessionsController < ApplicationController
  before_action :reset_session, only: [:create, :destroy]
  expose(:users_repository) { UsersRepository.new }

  def new
    redirect_to '/auth/slack'
  end

  def create
    user = users_repository.user_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to app_path, notice: 'Signed in!'
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
