class AuthenticatedController < ApplicationController
  before_filter :authenticate_user!

  def main_app; end
end
