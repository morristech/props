require 'rails_helper'

describe UsersRepository do
  let(:user) { create(:user) }
  let(:archived_user) { create(:user, archived_at: Time.now) }
  let(:repo) { described_class.new }

  describe '#find_by_id' do
    it 'returns active user' do
      expect(repo.find_by_id(user.id)).to eq(user)
    end

    it 'returns archived users' do
      expect(repo.find_by_id(archived_user.id)).to eq(archived_user)
    end
  end
end
