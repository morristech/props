class ApplicationMailer < ActionMailer::Base
  default from: "props@#{AppConfig.app_domain}"
  layout 'mailer'
end
