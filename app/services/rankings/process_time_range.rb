module Rankings
  class ProcessTimeRange
    pattr_initialize :time_range_string
    TIME_RANGE_ARRAY = %w(yearly monthly weekly bi-weekly all).freeze
    private_constant :TIME_RANGE_ARRAY

    def time_range
      time_range_allowed?
      evaluate_time_range
    end

    def time_interval
      time_range_allowed?
      count_time_interval
    end

    private

    def time_range_allowed?
      raise 'Wrong time range' unless TIME_RANGE_ARRAY.include? time_range_string
    end

    def evaluate_time_range
      time_range_hash.fetch(time_range_string) { raise 'Wrong time range' }
    end

    def time_range_hash
      {
        'yearly' => (1.year.ago..Time.current),
        'monthly' => (1.month.ago..Time.current),
        'weekly' => (1.week.ago..Time.current),
        'bi-weekly' => (2.weeks.ago..Time.current),
        'all' => (Prop.order(:created_at).first.created_at..Time.current),
      }
    end

    def count_time_interval
      return 'month' if time_range_string.inquiry.yearly? || time_range_above_two_months?
      'day'
    end

    def time_range_above_two_months?
      return unless time_range_string.inquiry.all?
      Prop.oldest_first.created_at < 2.months.ago
    end
  end
end
