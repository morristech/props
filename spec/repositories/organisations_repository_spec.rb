require 'rails_helper'
require_relative '../../app/repositories/organisations_repository'

describe OrganisationsRepository do
  describe '#from_auth' do
    it 'returns organisation from database with matching team_id' do
      team_id = 'team_id'
      org_from_db = create :organisation, team_id: team_id
      auth = { 'info' => { 'team_id' => team_id } }

      expect(described_class.new.from_auth(auth)).to eq(org_from_db)
    end

    it "creates organisation if it doesn't exist" do
      team_id = 'team_id'
      team_name = 'team_name'
      auth = { 'info' => { 'team_id' => team_id, 'team' => team_name } }

      organisation = described_class.new.from_auth(auth)

      expect(organisation.team_id).to eq(team_id)
      expect(organisation.name).to eq(team_name)
    end
  end
end

