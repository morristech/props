class OrganisationsRepository
  def from_auth(auth)
    Organisation.where(team_id: auth['info']['team_id']).first_or_create do |organisation|
      organisation.team_id = auth['info']['team_id']
      organisation.name = auth['info']['team']
    end
  end
end
