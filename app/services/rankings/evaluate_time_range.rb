module Rankings
  class EvaluateTimeRange
    pattr_initialize :time_range

    def call
      evaluate_time_range
    end

    private

    def evaluate_time_range
      time_range_hash.fetch(time_range) { raise 'Wrong params' }
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
  end
end
