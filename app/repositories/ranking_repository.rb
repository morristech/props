class RankingRepository
  pattr_initialize :users_repository, :props_repository, :time_range

  def hero_of_the_week
    # time_range = (Time.zone.now.beginning_of_week..Time.zone.now)
    top_propser = top_propser_within evaluate_time_range
    {
      user: top_propser.name,
      props_count: top_propser.props_count,
    }
  end

  def top_kudoers
    top_kudoers = top_kudoers_within evaluate_time_range
  end

  private

  def top_propser_within(time_range)
    UserWithPropsCount.from_array(
      users_repository,
      props_repository.count_per_user(time_range).max_by { |_k, v| v },
    )
  end

  def top_kudoers_within(time_range)
    hash = props_repository.count_per_user(time_range).sort_by { |_k, v| v }.reverse.to_h
    hash.each_with_object({}) do |(k, v), hsh| 
      name = users_repository.find_by_id(k).name
      hsh[name]=v 
    end
  end

  def evaluate_time_range
    case time_range
    when "year"
      (Time.zone.now - 1.year..Time.zone.now)
    when "month"
      (Time.zone.now - 1.month..Time.zone.now)
    when "week"
      (Time.zone.now - 1.week..Time.zone.now)
    when "all"
      (Prop.order(:created_at).first.created_at..Time.zone.now)
    else
      puts "oops"
    end
  end

  class UserWithPropsCount
    vattr_initialize :props_count, :name

    def self.from_array(users_repository, arr)
      new arr[1], users_repository.find_by_id(arr[0]).name
    end
  end
end
