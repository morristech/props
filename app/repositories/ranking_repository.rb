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
    kudos_streak_within
  end

  private

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

  def kudos_streak_within
    kudos_with_receivers = props_repository.kudos_with_receivers(evaluate_time_range)
    splitted_array = split_on_users(kudos_with_receivers)
    sort_on_streak_count serialize_streak(splitted_array)
  end

  def split_on_users(kudos_with_receivers)
    kudos_with_receivers.chunk_while { |a, b| a.first == b.first }.to_a
  end

  def sort_on_streak_count(users_streak)
    users_streak.sort { |x, y| y[:streak] <=> x[:streak] }
  end

  def serialize_streak(splitted_array)
    splitted_array.each_with_object([]) do |elem, arr|
      arr.push(
        streak: count_user_streak(elem),
        user: serialized_users[elem.first.first],
      )
    end
  end

  def count_user_streak(user_and_kudos_date)
    user_and_kudos_date.uniq.chunk_while { |a, b| a.second + 1.day == b.second }.map(&:count).max
  end

  def serialized_users
    @serialized_users ||= users_repository.all_users_serialized
  end

  def evaluate_time_range
    case time_range
    when 'yearly' then (Time.zone.now - 1.year..Time.zone.now)
    when 'monthly' then (Time.zone.now - 1.month..Time.zone.now)
    when 'weekly' then (Time.zone.now - 1.week..Time.zone.now)
    when 'bi-weekly' then (Time.zone.now - 2.weeks..Time.zone.now)
    when 'all' then (Prop.order(:created_at).first.created_at..Time.zone.now)
    else raise 'Wrong params'
    end
  end

  def count_time_interval
    return 'month' if time_range == 'yearly' || time_range_above_two_months?
    'day'
  end

  def time_range_above_two_months?
    return unless time_range == 'all'
    Prop.oldest_first.created_at < Time.zone.now - 2.months
  end
end
