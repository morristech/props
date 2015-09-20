class ApplicationMailer < ActionMailer::Base
  default from: AppConfig.emails.default_from
  layout 'mailer'
end
