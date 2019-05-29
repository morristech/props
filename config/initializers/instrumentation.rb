require 'yabeda'

Yabeda::Rails.install!

Yabeda.configure do
  BUCKETS = [0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10].freeze

  # DB queries metrics
  group :db_query do
    counter   :total, comment: 'A counter of the total number of DB queries.'
    histogram :duration, unit: :seconds, buckets: BUCKETS, comment: 'A histogram of the DB query response latency.'
  end

  ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    labels = { name: event.payload[:name] }
    db_query_total.increment(labels)
    db_query_duration.measure(labels, (event.duration / 1000).round(3))
  end

  # Grape API metrics
  group :grape_api do
    counter   :requests_total, comment: 'A counter of the total number of HTTP requests grape_api processed.'
    histogram :request_duration, unit: :seconds, buckets: BUCKETS,
                                 comment: 'A histogram of the response latency.'
    histogram :view_runtime, unit: :seconds, buckets: BUCKETS,
                             comment: 'A histogram of the view rendering time.'
    histogram :db_runtime, unit: :seconds, buckets: BUCKETS,
                           comment: 'A histogram of the activerecord execution time.'
  end

  ActiveSupport::Notifications.subscribe('grape') do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    labels = {
      path: event.payload[:path],
      status: event.payload[:status],
      method: event.payload[:method].downcase,
    }
    grape_api_requests_total.increment(labels)
    grape_api_request_duration.measure(labels, (event.payload[:time][:total].to_f / 1000).round(3))
    grape_api_view_runtime.measure(labels, (event.payload[:time][:view].to_f / 1000).round(3))
    grape_api_db_runtime.measure(labels, (event.payload[:time][:db].to_f / 1000).round(3))
  end
end
