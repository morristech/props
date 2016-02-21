require 'rake'

namespace :email_digests do
  desc 'Create subscriptions for new users'
  task create_subscriptions: :environment do
    EmailDigests::CreateSubscriptions.new.call
  end

  desc "Sends email digests to users about props they've received"
  task send_weekly: :environment do
    EmailDigests::SendWeekly.new.call
  end

  desc "Sends email digests to users about props they've received"
  task send_daily: :environment do
    EmailDigests::SendDaily.new.call
  end
end
