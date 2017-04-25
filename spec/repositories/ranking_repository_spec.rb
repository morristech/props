require 'rails_helper'

describe RankingRepository do
  describe '#hero_of_the_week' do
    let(:organisation) { create(:organisation) }
    let(:mark) { create(:user) }
    let(:john) { create(:user) }
    let(:jane) { create(:user, name: 'Jane Doe') }
    let!(:props) do
      [
        create_prop_for_user(jane, mark),
        create_prop_for_user(jane, john),
        create_prop_for_user(mark, john),
      ]
    end
    let(:props_repository) { PropsRepository.new }
    let(:users_repository) { UsersRepository.new }
    let(:repo) { described_class.new(users_repository, props_repository) }

    it 'returns the user with the most props' do
      expected_result = { user: 'Jane Doe', props_count: 2 }
      expect(repo.hero_of_the_week).to eq expected_result
    end

    def create_prop_for_user(user, propser)
      attrs = attributes_for(:prop).merge(user_ids: user.id.to_s,
                                          propser_id: propser.id,
                                          organisation: organisation)
      PropsRepository.new.add(attrs)
    end
  end
end
