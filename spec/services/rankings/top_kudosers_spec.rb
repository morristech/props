require 'rails_helper'
include RankingsHelpers

describe Rankings::TopKudosers do
  let(:organisation) { create(:organisation) }
  let(:mark) { create(:user) }
  let(:john) { create(:user) }
  let(:jane) { create(:user, name: 'Jane Doe') }
  let(:props_repository) { PropsRepository.new }
  let(:users_repository) { UsersRepository.new }
  let(:time_range_processor) { Rankings::ProcessTimeRange.new(time_range_string) }
  let(:time_range) { time_range_processor.time_range }

  subject { described_class.new(users_repository, props_repository, time_range) }

  describe '#hero_of_the_week' do
    let(:time_range_string) { 'weekly' }
    let(:time_now) { Time.zone.now }
    let!(:kudos) do
      [
        create_kudos_for_user(jane, mark, time_now),
        create_kudos_for_user(jane, john, time_now),
        create_kudos_for_user(mark, john, time_now),
      ]
    end
    let(:expected_result) do
      {
        user: jane.name,
        kudos_count: 2,
      }
    end

    it 'returns the user with the most kudos' do
      expect(subject.hero_of_the_week).to eq expected_result
    end

  end

  describe '#top_kudosers' do
    let(:time_now) { Time.zone.now }
    let!(:kudos) do
      [
        create_kudos_for_user(jane, mark, time_now),
        create_kudos_for_user(jane, john, time_now - 2.days),
        create_kudos_for_user(mark, john, time_now - 5.days),
        create_kudos_for_user(jane, john, time_now - 2.weeks),
        create_kudos_for_user(mark, jane, time_now - 3.months),
        create_kudos_for_user(mark, jane, time_now - 5.months),
        create_kudos_for_user(mark, jane, time_now - 7.months),
        create_kudos_for_user(mark, jane, time_now - 2.years),
        create_kudos_for_user(john, jane, time_now - 2.years),
      ]
    end

    def user_with_kudos_count(user, kudos_count)
      {
        kudos_count: kudos_count,
        user: {
          'id' => user.id,
          'name' => user.name,
          'email' => user.email,
          'uid' => user.uid,
          'avatar' => user.avatar,
        },
      }
    end

    context 'when statistics are requested in weekly time range' do
      let(:expected_result) do
        {
          top_kudosers: [
            user_with_kudos_count(jane, 2),
            user_with_kudos_count(mark, 1),
          ],
        }
      end
      let(:time_range_string) { 'weekly' }

      it 'returns users with their kudos count from last week' do
        expect(subject.top_kudosers).to eq expected_result
      end
    end

    context 'when statistics are requested in monthly time range' do
      let(:expected_result) do
        {
          top_kudosers: [
            user_with_kudos_count(jane, 3),
            user_with_kudos_count(mark, 1),
          ],
        }
      end
      let(:time_range_string) { 'monthly' }

      it 'returns users with their kudos count from last month' do
        expect(subject.top_kudosers).to eq expected_result
      end
    end

    context 'when statistics are requested in yearly time range' do
      let(:expected_result) do
        {
          top_kudosers: [
            user_with_kudos_count(mark, 4),
            user_with_kudos_count(jane, 3),
          ],
        }
      end
      let(:time_range_string) { 'yearly' }

      it 'returns users with their kudos count from last year' do
        expect(subject.top_kudosers).to eq expected_result
      end
    end

    context 'when statistics are requested in etire time range' do
      let(:expected_result) do
        {
          top_kudosers: [
            user_with_kudos_count(mark, 5),
            user_with_kudos_count(jane, 3),
            user_with_kudos_count(john, 1),
          ],
        }
      end
      let(:time_range_string) { 'all' }

      it 'returns users with their kudos count' do
        expect(subject.top_kudosers).to eq expected_result
      end
    end
  end
end
