class AuthenticatedController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_domain!
  before_filter :redirect_netguru_subdomain_to_root

  def main_app; end
end
