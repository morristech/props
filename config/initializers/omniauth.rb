Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, AppConfig.omniauth_provider_key, AppConfig.omniauth_provider_secret,
    {
      approval_prompt: 'auto',
      access_type: 'online',
      hd: AppConfig.domain_name
    }
  provider :slack, AppConfig.slack.api_key, AppConfig.slack.api_secret, scope: 'team:read,users:read,identify,identity:email'
end


# slack_uid np: U02GX4SC1
# first_name #edit on reg page
# last_name #edit on req page
# email #edit on req page
#
# {"provider"=>"slack",
#  "uid"=>"U02GX4SC1",
#  "info"=>
#   {"nickname"=>"kamil",
#    "team"=>"Netguru",
#    "user"=>"kamil",
#    "team_id"=>"T0251EZGA",
#    "user_id"=>"U02GX4SC1",
#    "name"=>"Kamil Paszkowski",
#    "email"=>nil,
#    "first_name"=>"Kamil",
#    "last_name"=>"Paszkowski",
#    "description"=>"Web developer",
#    "image_24"=>"https://avatars.slack-edge.com/2014-08-24/2575173113_24.jpg",
#    "image_48"=>"https://avatars.slack-edge.com/2014-08-24/2575173113_48.jpg",
#    "image"=>"https://avatars.slack-edge.com/2014-08-24/2575173113_192.jpg",
#    "team_domain"=>"netguru",
#    "is_admin"=>true,
#    "is_owner"=>false,
#    "time_zone"=>"Europe/Amsterdam"},
#  "credentials"=>{"token"=>"xoxp-2171509554-2575162409-147443008497-e97f7e058cf3165c6938c77d0f036b26", "expires"=>false},
#  "extra"=>
#   {"raw_info"=>{"ok"=>true, "url"=>"https://netguru.slack.com/", "team"=>"Netguru", "user"=>"kamil", "team_id"=>"T0251EZGA", "user_id"=>"U02GX4SC1"},
#    "web_hook_info"=>{},
#    "bot_info"=>{},
#    "user_info"=>
#     {"ok"=>true,
#      "user"=>
#       {"id"=>"U02GX4SC1",
#        "team_id"=>"T0251EZGA",
#        "name"=>"kamil",
#        "deleted"=>false,
#        "status"=>nil,
#        "color"=>"3c8c69",
#        "real_name"=>"Kamil Paszkowski",
#        "tz"=>"Europe/Amsterdam",
#        "tz_label"=>"Central European Time",
#        "tz_offset"=>3600,
#        "profile"=>
#         {"first_name"=>"Kamil",
#          "last_name"=>"Paszkowski",
#          "image_24"=>"https://avatars.slack-edge.com/2014-08-24/2575173113_24.jpg",
#          "image_32"=>"https://avatars.slack-edge.com/2014-08-24/2575173113_32.jpg",
#          "image_48"=>"https://avatars.slack-edge.com/2014-08-24/2575173113_48.jpg",
#          "image_72"=>"https://avatars.slack-edge.com/2014-08-24/2575173113_72.jpg",
#          "image_192"=>"https://avatars.slack-edge.com/2014-08-24/2575173113_192.jpg",
#          "image_original"=>"https://avatars.slack-edge.com/2014-08-24/2575173113_original.jpg",
#          "title"=>"Web developer",
#          "skype"=>"kamilpasz",
#          "phone"=>"",
#          "avatar_hash"=>"OS2575173113",
#          "real_name"=>"Kamil Paszkowski",
#          "real_name_normalized"=>"Kamil Paszkowski"},
#        "is_admin"=>true,
#        "is_owner"=>false,
#        "is_primary_owner"=>false,
#        "is_restricted"=>false,
#        "is_ultra_restricted"=>false,
#        "is_bot"=>false,
#        "has_2fa"=>false}},
#    "team_info"=>
#     {"ok"=>true,
#      "team"=>
#       {"id"=>"T0251EZGA",
#        "name"=>"Netguru",
#        "domain"=>"netguru",
#        "email_domain"=>"netguru.pl",
#        "icon"=>
#         {"image_34"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-10-03/86737834019_5926eca11a417f9745b9_34.png",
#          "image_44"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-10-03/86737834019_5926eca11a417f9745b9_44.png",
#          "image_68"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-10-03/86737834019_5926eca11a417f9745b9_68.png",
#          "image_88"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-10-03/86737834019_5926eca11a417f9745b9_88.png",
#          "image_102"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-10-03/86737834019_5926eca11a417f9745b9_102.png",
#          "image_132"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-10-03/86737834019_5926eca11a417f9745b9_132.png",
#          "image_original"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-10-03/86737834019_5926eca11a417f9745b9_original.png",
#          "image_230"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-10-03/86737834019_5926eca11a417f9745b9_230.png"}}}}}
