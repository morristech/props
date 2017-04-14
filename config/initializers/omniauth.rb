Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :slack,
    AppConfig.omniauth_provider_key,
    AppConfig.omniauth_provider_secret,
    scope: 'identify,team:read,users.profile:read,users:read,users:read.email,chat:write:bot',
  )
end

OmniAuth.configure do |config|
  config.failure_raise_out_environments = []
end
