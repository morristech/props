# Learn more: http://github.com/javan/whenever

# Monday-Friday at 4:00PM
every "0 4 * * 1-5" do
  rake "email_digests:send_daily"
end

every :friday, at: "4pm" do
  rake "email_digests:weekly"
end
