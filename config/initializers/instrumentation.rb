require 'yabeda'

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

  group :perform do
    counter     :active_job_total, comment: 'perform total'
    histogram   :active_job_duration, unit: :seconds, buckets: BUCKETS, comment: 'active job duration'
  end

  ActiveSupport::Notifications.subscribe('perform.active_job') do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    labels = {
      adapter: event.payload[:adapter],
      active_job_class: event.payload[:job].class,
    }
    perform_active_job_total.increment(labels)
    perform_active_job_duration.measure(labels, (event.duration / 1000).round(3))
  end

  group :deprecation do
    counter     :test, comment: 'comment'
  end

  ActiveSupport::Notifications.subscribe('deprecation.rails') do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    labels = {
      message: event.payload[:message],
      callstack: event.payload[:callstack]
    }
    deprecation_test.increment(labels)
  end

  group :application do
    counter     :props_given, comment: "props given"
    counter     :props_email_sent, comment: "props email sent"
  end

  group :sidekiq do
    gauge     :processed, comment: "processed"
    gauge     :failed, comment: "failed"
    gauge     :workers_size, comment: "workers size"
    gauge     :enqueued, comment: "enqueued"

    stats = Sidekiq::Stats.new

    sidekiq.processed.set({}, stats.processed)
    sidekiq.failed.set({}, stats.failed)
    sidekiq.workers_size.set({}, stats.workers_size)
    sidekiq.enqueued.set({}, stats.enqueued)
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
