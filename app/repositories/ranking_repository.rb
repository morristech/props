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
    sorted_kudos_streak
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
    serialized_users = users_repository.all_users_serialized
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

  def sorted_kudos_streak
    kudos_streak_within.sort { |x, y| y[:streak] <=> x[:streak] }
  end

  def kudos_streak_within
    users_with_kudos_count.each_with_object([]) do |(user_id, _), arr|
      user = User.find(user_id)
      streak = count_user_streak(user)
      arr.push(
        streak: streak.max,
        user: users_repository.user_serialized(user),
      )
    end
  end

  def count_user_streak(user)
    streak = [1]
    users_kudos = user.props.where(created_at: evaluate_time_range).order(:created_at)
    users_kudos.each_cons(2) do |kudos_pair|
      next if kudos_same_date?(kudos_pair)
      kudos_from_two_continuos_days?(kudos_pair) ? streak[-1] += 1 : streak.push(1)
    end
    streak
  end

  def kudos_from_two_continuos_days?(kudos_pair)
    first_date = kudos_pair.first.created_at
    second_date = kudos_pair.second.created_at

    (first_date + 1.day).to_date == second_date.to_date
  end

  def kudos_same_date?(kudos_array)
   kudos_array.map(&:created_at).map(&:to_date).uniq.one?
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
