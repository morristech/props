class PropsDigest < ApplicationMailer
  def received(user, props)
    @props = props
    @user = user
    if AppConfig.sendgrid_password.present?
      Yabeda.application.props_email_sent.increment(by: 1)
      mail(to: user.email, subject: 'Received props digest')
    end
  end
end
