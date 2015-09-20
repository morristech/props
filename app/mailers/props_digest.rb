class PropsDigest < ApplicationMailer
  def received(user, props)
    @props = props
    @user = user
    mail(to: user.email, subject: 'Received props digest')
  end
end
