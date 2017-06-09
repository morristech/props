require 'rails_helper'

describe RankingRepository do
  let(:organisation) { create(:organisation) }
  let(:mark) { create(:user) }
  let(:john) { create(:user) }
  let(:jane) { create(:user, name: 'Jane Doe') }
  let(:props_repository) { PropsRepository.new }
  let(:users_repository) { UsersRepository.new }
  let(:repo) { described_class.new(users_repository, props_repository, time_range) }

  def create_kudos_for_user(user, propser, created_at)
    kudos_attrs = {
      user_ids: user.id.to_s,
      propser_id: propser.id,
      organisation: organisation,
      created_at: created_at,
    }
    attrs = attributes_for(:prop).merge(kudos_attrs)
    PropsRepository.new.add(attrs)
  end

  describe '#hero_of_the_week' do
    let(:time_range) { 'weekly' }
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
      expect(repo.hero_of_the_week).to eq expected_result
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
      let(:time_range) { 'weekly' }

      it 'returns users with their kudos count from last week' do
        expect(repo.top_kudosers).to eq expected_result
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
      let(:time_range) { 'monthly' }

      it 'returns users with their kudos count from last month' do
        expect(repo.top_kudosers).to eq expected_result
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
      let(:time_range) { 'yearly' }

      it 'returns users with their kudos count from last year' do
        expect(repo.top_kudosers).to eq expected_result
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
      let(:time_range) { 'all' }

      it 'returns users with their kudos count' do
        expect(repo.top_kudosers).to eq expected_result
      end
    end
  end

  describe '#team_activity' do
    let(:today) { Time.zone.now }
    let!(:kudos) do
      [
        create_kudos_for_user(jane, mark, today),
        create_kudos_for_user(jane, john, today - 2.days),
        create_kudos_for_user(mark, john, today - 2.days),
        create_kudos_for_user(jane, john, today - 3.weeks),
        create_kudos_for_user(mark, jane, today - 4.months),
      ]
    end

    context 'when statistics are requested in weekly time range' do
      let(:time_range) { 'weekly' }
      let(:expected_result) do
        {
          (today - 2.days).beginning_of_day => 2,
          today.beginning_of_day => 1,
        }
      end

      it 'returns time stamps with organisation kudos count from last week' do
        expect(repo.team_activity).to eq expected_result
      end
    end

    context 'when statistics are requested in monthly time range' do
      let(:time_range) { 'monthly' }
      let(:expected_result) do
        {
          (today - 3.weeks).beginning_of_day => 1,
          (today - 2.days).beginning_of_day => 2,
          today.beginning_of_day => 1,
        }
      end

      it 'returns time stamps with organisation kudos count from last month' do
        expect(repo.team_activity).to eq expected_result
      end
    end

    context 'when returned statictics should be grouped by months' do
      let(:this_month) { Time.zone.now.beginning_of_month }
      let!(:kudos) do
        [
          create_kudos_for_user(jane, mark, this_month + 1.day),
          create_kudos_for_user(jane, john, this_month - 2.days),
          create_kudos_for_user(mark, john, this_month - 5.days),
          create_kudos_for_user(jane, john, this_month - 4.weeks),
          create_kudos_for_user(mark, jane, this_month - (6.months + 2.days)),
          create_kudos_for_user(mark, jane, this_month - (13.months + 2.days)),
          create_kudos_for_user(mark, jane, this_month - (15.months + 2.days)),
        ]
      end

      context 'when statistics are requested in yearly time range' do
        let(:time_range) { 'yearly' }
        let(:expected_result) do
          {
            this_month - 7.months => 1,
            this_month - 1.month => 3,
            this_month => 1,
          }
        end

        it 'returns time stamps with organisation kudos count from last year' do
          expect(repo.team_activity).to eq expected_result
        end
      end

      context 'when statistics are requested in etire time range' do
        let(:time_range) { 'all' }

        context 'when kudos were given in long time range' do
          let(:expected_result) do
            {
              this_month - 16.months => 1,
              this_month - 14.months => 1,
              this_month - 7.months => 1,
              this_month - 1.month => 3,
              this_month => 1,
            }
          end

          it 'returns time stamps with organisation kudos count in month interval' do
            expect(repo.team_activity).to eq expected_result
          end
        end

        context 'when first kudos were given not long ago' do
          let!(:kudos) do
            [
              create_kudos_for_user(jane, mark, this_month + 1.day),
              create_kudos_for_user(mark, john, this_month + 1.day),
              create_kudos_for_user(jane, john, this_month - 2.days),
              create_kudos_for_user(mark, john, this_month - 5.days),
              create_kudos_for_user(jane, john, this_month - 4.weeks),
            ]
          end
          let(:expected_result) do
            {
              this_month - 4.weeks => 1,
              this_month - 5.days => 1,
              this_month - 2.days => 1,
              this_month + 1.day => 2,
            }
          end

          it 'returns time stamps with organisation kudos count in day interval' do
            expect(repo.team_activity).to eq expected_result
          end
        end
      end
    end
  end

  describe '#kudos_streak' do
    def user_with_streak(user, streak)
      {
        streak: streak,
        user: {
          'id' => user.id,
          'name' => user.name,
          'email' => user.email,
          'uid' => user.uid,
          'avatar' => user.avatar,
        },
      }
    end

    let(:today) { Time.zone.now }
    let(:two_weeks_ago) { Time.zone.now - 2.weeks }
    let(:three_months_ago) { Time.zone.now - 3.months }
    let(:two_years_ago) { Time.zone.now - 2.years }
    let!(:kudos) do
      [
        create_kudos_for_user(jane, mark, today),
        create_kudos_for_user(mark, john, two_weeks_ago),
        create_kudos_for_user(mark, john, two_weeks_ago - 1.day),
        create_kudos_for_user(jane, john, three_months_ago),
        create_kudos_for_user(jane, john, three_months_ago - 1.day),
        create_kudos_for_user(jane, john, three_months_ago - 2.days),
        create_kudos_for_user(john, jane, two_years_ago),
      ]
    end

    context 'when statistics are requested in weekly time range' do
      let(:time_range) { 'weekly' }
      let(:expected_result) do
        [
          user_with_streak(jane, 1),
        ]
      end

      it 'returns users with their highest kudos streaks within last week' do
        expect(repo.kudos_streak).to eq expected_result
      end
    end

    context 'when statistics are requested in monthly time range' do
      let(:time_range) { 'monthly' }
      let(:expected_result) do
        [
          user_with_streak(mark, 2),
          user_with_streak(jane, 1),
        ]
      end

      it 'returns users with their highest kudos streaks within last month' do
        expect(repo.kudos_streak).to eq expected_result
      end
    end

    context 'when statistics are requested in yearly time range' do
      let(:time_range) { 'yearly' }
      let(:expected_result) do
        [
          user_with_streak(jane, 3),
          user_with_streak(mark, 2),
        ]
      end

      it 'returns users with their highest kudos streaks within last year' do
        expect(repo.kudos_streak).to eq expected_result
      end
    end

    context 'when statistics are requested in etire time range' do
      let(:time_range) { 'all' }
      let(:expected_result) do
        [
          user_with_streak(jane, 3),
          user_with_streak(mark, 2),
          user_with_streak(john, 1),
        ]
      end

      it 'returns users with their highest kudos streaks' do
        expect(repo.kudos_streak).to eq expected_result
      end

      context 'when user get few kudos at the same day it does not count to streak' do
        let(:time_range) { 'all' }
        let!(:kudos) do
          [
            create_kudos_for_user(jane, mark, today),
            create_kudos_for_user(jane, mark, today),
            create_kudos_for_user(jane, mark, today),
            create_kudos_for_user(jane, mark, today),
            create_kudos_for_user(mark, john, two_weeks_ago),
            create_kudos_for_user(mark, john, two_weeks_ago),
            create_kudos_for_user(mark, john, two_weeks_ago),
            create_kudos_for_user(mark, john, two_weeks_ago - 1.day),
            create_kudos_for_user(jane, john, three_months_ago),
            create_kudos_for_user(jane, john, three_months_ago - 1.day),
            create_kudos_for_user(jane, john, three_months_ago - 1.day),
            create_kudos_for_user(jane, john, three_months_ago - 1.day),
            create_kudos_for_user(jane, john, three_months_ago - 2.days),
            create_kudos_for_user(john, jane, two_years_ago),
          ]
        end
        let(:expected_result) do
          [
            user_with_streak(jane, 3),
            user_with_streak(mark, 2),
            user_with_streak(john, 1),
          ]
        end

        it 'returns users with their highest kudos streaks' do
          expect(repo.kudos_streak).to eq expected_result
        end
      end
    end
  end
end
