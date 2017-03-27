module SessionConcern
  extend ActiveSupport::Concern

  def sign_in_user(user)
    session[:user_id] = user.id
  end
end
