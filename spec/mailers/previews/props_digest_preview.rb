# Preview all emails at http://localhost:3000/rails/mailers/props_digest
class PropsDigestPreview < ActionMailer::Preview
  def received
    PropsDigest.received(User.all.sample, Prop.all.sample(10))
  end
end
