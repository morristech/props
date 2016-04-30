class AuthenticatedController < ApplicationController
  before_action :authenticate_user!

  def main_app
    render react_component: 'AppContainer'
  end
end
