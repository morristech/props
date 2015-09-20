require 'rake'

namespace :email_digests do
  desc "Sends email digests to users about props they've received"
  task send_weekly: :environment do
    EmailDigests::SendWeekly.new.call
  end

  desc "Sends email digests to users about props they've received"
  task send_daily: :environment do
    EmailDigests::SendDaily.new.call
  end
end
