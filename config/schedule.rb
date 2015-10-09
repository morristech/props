# Learn more: http://github.com/javan/whenever

# Monday-Friday at 17:00
every "0 17 * * 1-5" do
  rake "email_digests:send_daily"
end

every :friday, at: "4pm" do
  rake "email_digests:weekly"
end

every 1.day, at: "3pm" do
  rake "email_digests:create_subscriptions"
end
