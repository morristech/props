class RankingRepository
  pattr_initialize :users_repository, :props_repository, :time_range

  def hero_of_the_week
    top_propser_within
  end

  def top_kudoers
    top_kudoers_within
  end

  def team_activity
    team_activity_within
  end

  def kudos_streak
    sorted_kudos_streak
  end

  private

  def top_propser_within
    id_with_count = users_with_kudos_count.max_by { |_k, v| v }
    user = User.find(id_with_count.first)
    props_count = id_with_count.second
    {
      user: user.name,
      props_count: props_count,
    }
  end

  def users_with_kudos_count
    props_repository.count_per_user(evaluate_time_range)
  end

  def top_kudoers_within
    serialized_users = users_repository.all_users_serialized
    sorted_users = users_with_kudos_count.sort_by { |_k, v| v }.reverse
    sorted_users.each_with_object(top_kudoers: []) do |arr, hsh|
      hsh[:top_kudoers].push(
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
    users_props = user.props.where(created_at: evaluate_time_range).order(:created_at)
    users_props.each_cons(2) do |props_pair|
      next if kudos_from_the_same_day?(props_pair)
      kudos_from_two_continuos_days?(props_pair) ? streak[-1] += 1 : streak.push(1)
    end
    streak
  end

  def kudos_from_two_continuos_days?(props_pair)
    first_day = props_pair.first.created_at
    second_day = props_pair.second.created_at

    (first_day + 2.days) > second_day && (first_day + 1.day).day == second_day.day
  end

  def kudos_from_the_same_day?(props_pair)
    first_day = props_pair.first.created_at
    second_day = props_pair.second.created_at

    (first_day + 2.days) > second_day && first_day.day == second_day.day
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
    return 'month' if time_range == 'yearly' || entire_time_range_is_long?
    'day'
  end

  def entire_time_range_is_long?
    return unless time_range == 'all'
    Prop.order(:created_at).first.created_at < Time.zone.now - 2.months
  end
end
