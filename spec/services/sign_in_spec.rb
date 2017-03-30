require 'spec_helper'
require_relative '../../app/services/users/sign_in'

describe Users::SignIn do
  describe '#call' do
    it 'returns object with user_id and organisation_id' do
      user = create_user
      users_repo = double('users_repo', user_from_auth: user)
      organisation = create_organisation
      organisations_repo = double('organisations_repo', from_auth: organisation)
      sign_in = create_sign_in(users_repo, organisations_repo)

      result = sign_in.call

      expect(result.user.id).to eq(user.id)
      expect(result.organisation.id).to eq(organisation.id)
    end

    it "adds user to the organisation" do
      user = create_user
      users_repo = double('users_repo', user_from_auth: user)
      organisation = create_organisation
      organisations_repo = double('organisations_repo', from_auth: organisation)
      sign_in = create_sign_in(users_repo, organisations_repo)

      sign_in.call

      expect(organisation).to have_received(:add_user).with(user)
    end
  end

  def create_organisation
    double('organisation', id: double('organisation id')).tap do |organisation|
      allow(organisation).to receive(:add_user)
    end
  end

  def create_user
    double('user', id: double('user id'))
  end

  def create_sign_in(users_repo, organisations_repo)
    described_class.new(auth: double('auth'),
                        users_repository: users_repo,
                        organisations_repository: organisations_repo)
  end
end
