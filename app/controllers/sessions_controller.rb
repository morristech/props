class SessionsController < ApplicationController
  before_action :reset_session, only: [:create, :destroy]

  def new
    redirect_to '/auth/slack'
  end

  def create
    sign_in = Users::SignIn.new(auth: request.env['omniauth.auth']).call
    session[:user_id] = sign_in.user_id
    session[:organisation_id] = sign_in.organisation_id
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
