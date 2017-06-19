require 'rails_helper'

describe RankingRepository do
  let(:repo) { described_class.new(users_repository, props_repository, time_range_string) }
  let(:users_repository) { double }
  let(:props_repository) { double(count_per_time_range: true) }
  let(:time_range_string) { 'weekly' }
  let(:time_range_processor) { double(time_range: time_range, time_interval: time_interval) }
  let(:time_range) { 1.week.ago..Time.current }
  let(:time_interval) { 'day' }

  before do
    allow(Rankings::ProcessTimeRange).to receive(:new).and_return(time_range_processor)
  end

  describe '#hero_of_the_week' do
    let(:ranking) { double(hero_of_the_week: true) }
    subject { repo.hero_of_the_week }
    before do
      allow(Rankings::TopKudosers).to receive(:new).and_return(ranking)
    end

    it 'instantiates TopKudosers once with correct params' do
      expect(Rankings::TopKudosers).to receive(:new).with(users_repository, props_repository, time_range).once
      subject
    end

    it 'calls TopKudosers#hero_of_the_week once on instantiated ranking' do
      expect(ranking).to receive(:hero_of_the_week).once
      subject
    end
  end

  describe '#top_kudosers' do
    let(:ranking) { double(top_kudosers: true) }
    subject { repo.top_kudosers }
    before do
      allow(Rankings::TopKudosers).to receive(:new).and_return(ranking)
    end

    it 'instantiates TopKudosers once with correct params' do
      expect(Rankings::TopKudosers).to receive(:new).with(users_repository, props_repository, time_range).once
      subject
    end

    it 'calls TopKudosers#top_kudosers once on instantiated ranking' do
      expect(ranking).to receive(:top_kudosers).once
      subject
    end
  end

  describe '#team_activity' do
    subject { repo.team_activity }

    it 'calls PropsRepository#count_per_time_range once on instantiated repository' do
      expect(props_repository).to receive(:count_per_time_range).with(time_interval, time_range).once
      subject
    end
  end

  describe '#kudos_streak' do
    let(:ranking) { double(kudos_streak: true) }
    subject { repo.kudos_streak }
    before do
      allow(Rankings::KudosStreak).to receive(:new).and_return(ranking)
    end

    it 'instantiates KudosStreak once with correct params' do
      expect(Rankings::KudosStreak).to receive(:new).with(users_repository, props_repository, time_range).once
      subject
    end

    it 'calls KudosStreak#kudos_streak once on instantiated ranking' do
      expect(ranking).to receive(:kudos_streak).once
      subject
    end
  end
end
