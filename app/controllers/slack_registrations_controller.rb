class SlackRegistrationsController < ApplicationController
  include SessionConcern

  before_action :check_organisation_existence

  def create_organisation
    binding.pry
    org_status, @organisation = Organisations::CrateFromSlack.new(organisation_omniauth_params).call
    user_status, @user = Users::CrateFromSlack.new(user_params).call
    if org_status.in?(:created, :found) && user_status.in?(:created, :found)
      sing_in_user(@user)
      redirect_to welcome_slack_registrations_path(subdomain: @organisation.subdomain)
    else
      render :registration_failed
    end
  end

  def create_user

  end

  def welcome

  end

  private

  def check_organisation_existence
    organisation = Organisation.find_by(slack_uid: organisation_omniauth_params[:slack_uid])
    return if organisation.nil?

    redirect_to app_path(subdomain: organisation.subdomain)
  end

  def user_omniauth_params
    base_params = request
                  .env['omniauth.auth']['info']
                  .slice(:user_id, :email, :first_name, :last_name, :image)
    base_params[:slack_uid] = base_params.delete(:user_id)
    base_params[:image_url] = base_params.delete(:image)
    base_params
  end

  def organisation_omniauth_params
    base_params = request
                  .env['omniauth.auth']['extra']['team_info']['team']
                  .slice(:id, :name, :domain, :icon)
    base_params[:image_url] = base_params.delete(:icon).fetch(:image_230)
    base_params[:subdomain] = base_params.delete(:domain)
    base_params[:slack_uid] = base_params.delete(:id)
    base_params
  end
end
