module Rankings
  class KudosStreak
    pattr_initialize :users_repository, :props_repository, :time_range

    def call
      kudos_streak_within
    end

    private

    def kudos_streak_within
      kudos_with_receivers = props_repository.kudos_with_receivers(time_range)
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
  end
end
