require 'rails_helper'

describe 'organisations:assign_unassigned_users_and_props' do
  include_context 'rake'

  it 'assigns unassigned users and props to the organisation' do
    expect_any_instance_of(MoveOrphanedToOrganisation).to receive(:call)
    subject.invoke(1)
  end
end
