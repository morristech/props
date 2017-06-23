module Rankings
  class ProcessTimeRange
    pattr_initialize %i(time_range_string! props_repository! organisation!)
    TIME_RANGE_ARRAY = %w(yearly monthly weekly bi-weekly all).freeze
    private_constant :TIME_RANGE_ARRAY

    def time_range
      validate_time_range
      evaluate_time_range
    end

    def time_interval
      validate_time_range
      count_time_interval
    end

    private

    def validate_time_range
      raise 'Wrong time range' unless TIME_RANGE_ARRAY.include? time_range_string
    end

    def evaluate_time_range
      time_range_hash.fetch(time_range_string)
    end

    def time_range_hash
      {
        'all' => all_time_range,
        'yearly' => (1.year.ago..Time.current),
        'monthly' => (1.month.ago..Time.current),
        'bi-weekly' => (2.weeks.ago..Time.current),
        'weekly' => (1.week.ago..Time.current),
      }
    end

    def all_time_range
      from_first_prop_until_now || (1.week.ago..Time.current)
    end

    def from_first_prop_until_now
      oldest_kudos_date..Time.current if any_kudos?
    end

    def count_time_interval
      return 'month' if time_range_string.inquiry.yearly? || time_range_above_two_months?
      'day'
    end

    def time_range_above_two_months?
      return unless time_range_string.inquiry.all?
      any_kudos? ? oldest_kudos_date < 2.months.ago : false
    end

    def oldest_kudos_date
      props_repository.oldest_kudos_date(organisation)
    end

    def any_kudos?
      props_repository.any_kudos?(organisation)
    end
  end
end
