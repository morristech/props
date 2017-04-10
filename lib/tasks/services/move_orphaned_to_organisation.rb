class MoveOrphanedToOrganisation
  def initialize(organisation_id)
    @organisation_id = organisation_id
  end

  def call
    Prop.where(organisation_id: nil).update_all(organisation_id: organisation_id)

    user_ids = User.select(:id).where.not(id: Membership.select(:user_id).all).map(&:id)

    Membership.create!(
      user_ids.map do |user_id|
        { user_id: user_id, organisation_id: organisation_id }
      end
    )
  end

  private

  attr_reader :organisation_id
end
