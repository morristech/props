class RankingRepository
  pattr_initialize %i(users_repository! props_repository! organisation! time_range_string!)

  def hero_of_the_week
    return no_kudos_yet unless organisation_has_kudos?
    Rankings::TopKudosers.new(users_repository: users_repository,
                              props_repository: props_repository,
                              organisation: organisation,
                              time_range: time_range).hero_of_the_week
  end

  def top_kudosers
    return no_kudos_yet unless organisation_has_kudos?
    Rankings::TopKudosers.new(users_repository: users_repository,
                              props_repository: props_repository,
                              organisation: organisation,
                              time_range: time_range).top_kudosers
  end

  def team_activity
    return no_kudos_yet unless organisation_has_kudos?
    props_repository.count_per_time_range(organisation, time_interval, time_range)
  end

  def kudos_streak
    return no_kudos_yet unless organisation_has_kudos?
    Rankings::KudosStreak.new(users_repository: users_repository,
                              props_repository: props_repository,
                              organisation: organisation,
                              time_range: time_range).kudos_streak
  end

  private

  def no_kudos_yet
    { text: 'Organisation does not have any kudos yet' }
  end

  def organisation_has_kudos?
    props_repository.any_kudos?(organisation)
  end

  def time_range
    Rankings::ProcessTimeRange.new(time_range_string).time_range
  end

  def time_interval
    Rankings::ProcessTimeRange.new(time_range_string).time_interval
  end
end
