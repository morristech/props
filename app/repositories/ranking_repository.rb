class RankingRepository
  pattr_initialize :users_repository, :props_repository, :time_range

  def hero_of_the_week
    top_kudoser_within
  end

  def top_kudosers
    top_kudosers_within
  end

  def team_activity
    team_activity_within
  end

  def kudos_streak
    Rankings::KudosStreak.new(users_repository, props_repository, evaluate_time_range).call
  end

  private

  def evaluate_time_range
    Rankings::EvaluateTimeRange.new(time_range).call
  end

  def top_kudoser_within
    id_with_count = users_with_kudos_count.max_by { |_k, v| v }
    user = User.find(id_with_count.first)
    kudos_count = id_with_count.second
    {
      user: user.name,
      kudos_count: kudos_count,
    }
  end

  def users_with_kudos_count
    props_repository.count_per_user(evaluate_time_range)
  end

  def top_kudosers_within
    sorted_users = users_with_kudos_count.sort_by { |_k, v| v }.reverse
    sorted_users.each_with_object(top_kudosers: []) do |arr, hsh|
      hsh[:top_kudosers].push(
        kudos_count: arr[1],
        user: serialized_users[arr[0]],
      )
    end
  end

  def team_activity_within
    props_repository.count_per_time_range(count_time_interval, evaluate_time_range)
  end

  def serialized_users
    @serialized_users ||= users_repository.all_users_serialized
  end

  def count_time_interval
    return 'month' if time_range.inquiry.yearly? || time_range_above_two_months?
    'day'
  end

  def time_range_above_two_months?
    return unless time_range.inquiry.all?
    Prop.oldest_first.created_at < 2.months.ago
  end
end
