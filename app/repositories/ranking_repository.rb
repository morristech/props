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
  
  private

  def top_propser_within
    props_repository.count_per_user(evaluate_time_range).max_by { |_k, v| v }
  end

  def top_kudoers_within
    props_repository.count_per_user(evaluate_time_range).sort_by { |_k, v| v }.reverse.to_h
  end

  def team_activity_within
    props_repository.count_per_time_range(evaluate_time_range, count_time_interval)
  end

  def evaluate_time_range
    case time_range
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
      puts "oops"
    end
  end

  def count_time_interval
    #TODO: change interval for "all"
    return "month" if time_range == "yearly" || "all"
    "day"
  end
end
