require 'rails_helper'

RSpec.describe Organisation do
  describe 'associations' do
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:users).through(:memberships) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
