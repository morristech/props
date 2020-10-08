require 'rake'
Rails.app_class.load_tasks

## copied from schedule.rb
Crono.perform(CronTasks::EmailDigests::SendDailyJob).every 1.week, on: :monday, at: "17:00"
Crono.perform(CronTasks::EmailDigests::SendDailyJob).every 1.week, on: :tuesday, at: "17:00"
Crono.perform(CronTasks::EmailDigests::SendDailyJob).every 1.week, on: :wednesday, at: "17:00"
Crono.perform(CronTasks::EmailDigests::SendDailyJob).every 1.week, on: :thursday, at: "17:00"
Crono.perform(CronTasks::EmailDigests::SendDailyJob).every 1.week, on: :friday, at: "17:00"

Crono.perform(CronTasks::EmailDigests::WeeklyJob).every 1.week, on: :friday, at: "16:00"

Crono.perform(CronTasks::EmailDigests::CreateSubscriptionsJob).every 1.day, at: "15:00"
