class RankingRepository
  pattr_initialize :users_repository, :props_repository, :time_range

  def hero_of_the_week
    {
      user: top_propser_within.first,
      props_count: top_propser_within.second,
    }
  end

  def top_kudoers
    top_kudoers_within
  end

  def team_activity
    team_activity_within
  end
  
  def kudos_streak
    kudos_streak_within
  end

  private

  def users_with_kudos_count
    props_repository.count_per_user(evaluate_time_range)
  end

  def top_propser_within
    props_repository.count_per_user(evaluate_time_range).max_by { |_k, v| v }
  end

  def top_kudoers_within
    users_kudos_count = users_with_kudos_count.sort_by { |_k, v| v }.reverse
      .each_with_object({ top_kudoers: [] }) do |arr, hsh|
        hsh[:top_kudoers].push(
          {
            kudos_count: arr[1],
            user: many_serialized_users[arr[0]],
          }
        )
      end
  end

  def team_activity_within
    props_repository.count_per_time_range(evaluate_time_range, count_time_interval)
  end

  def kudos_streak_within
    users_with_kudos_count.each_with_object({ streaks: [] }) do |(user_id, _), hsh|
      user = User.find(user_id)
      streak = count_user_streak(user)
      hsh[:streaks].push(
        {
          streak: streak.max,
          user: one_serialized_user(user)
        }
      )
    end
  end

  def count_user_streak(user)
    streak = [1]
    user.props.order(:created_at).each_cons(2) do |props_pair|
      first_day, second_day = props_pair.first.created_at, props_pair.second.created_at
      if (first_day + 2.day) > second_day && (first_day + 1.day).day == second_day.day
        streak[-1] += 1
      elsif (first_day + 2.day) > second_day && first_day.day == second_day.day
        next
      else
        streak.push(1)
      end
    end
    streak
  end

  def many_serialized_users
    attributes_to_serialize = %i(id name email avatar_url uid)
    @many_serialized_users ||= User.all.each_with_object({}) do |user, hsh|
      hsh[user.id] = user.serializable_hash(only: attributes_to_serialize)
    end
  end

  def one_serialized_user(user)
    attributes_to_serialize = %i(id name email avatar_url uid)
    user.serializable_hash(only: attributes_to_serialize)
  end

  def evaluate_time_range
    @evaluated_time_range ||= case time_range
    when "yearly"
      (Time.zone.now - 1.year..Time.zone.now)
    when "monthly"
      (Time.zone.now - 1.month..Time.zone.now)
    when "weekly"
      (Time.zone.now - 1.week..Time.zone.now)
    when "bi-weekly"
      (Time.zone.now - 2.week..Time.zone.now)
    when "all"
      (Prop.order(:created_at).first.created_at..Time.zone.now)
    else
      raise "Wrong params"
    end
  end

  def count_time_interval
    #TODO: change interval for "all"
    return "month" if %w(yearly all).include?(time_range)
    "day"
  end
end
