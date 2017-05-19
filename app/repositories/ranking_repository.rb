class RankingRepository
  pattr_initialize :users_repository, :props_repository

  def hero_of_the_week
    time_range = (Time.zone.now.beginning_of_week..Time.zone.now)
    top_propser = top_propser_within time_range
    {
      user: top_propser.name,
      props_count: top_propser.props_count,
    }
  end

  private

  def top_propser_within(time_range)
    UserWithPropsCount.from_array(
      users_repository,
      props_repository.count_per_user(time_range).max_by { |_k, v| v },
    )
  end

  class UserWithPropsCount
    vattr_initialize :props_count, :name

    def self.from_array(users_repository, arr)
      new arr[1], users_repository.find_by_id(arr[0]).name
    end
  end
end
