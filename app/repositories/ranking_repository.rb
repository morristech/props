class RankingRepository
  pattr_initialize :users_repository, :props_repository, :time_range_string

  def hero_of_the_week
    Rankings::TopKudosers.new(users_repository, props_repository, time_range).hero_of_the_week
  end

  def top_kudosers
    Rankings::TopKudosers.new(users_repository, props_repository, time_range).top_kudosers
  end

  def team_activity
    props_repository.count_per_time_range(time_interval, time_range)
  end

  def kudos_streak
    Rankings::KudosStreak.new(users_repository, props_repository, time_range).kudos_streak
  end

  private

  def time_range
    Rankings::ProcessTimeRange.new(time_range_string).time_range
  end

  def time_interval
    Rankings::ProcessTimeRange.new(time_range_string).time_interval
  end
end
