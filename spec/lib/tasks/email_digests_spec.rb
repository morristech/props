require 'rails_helper'

describe 'email_digests:create_subscriptions' do
  include_context 'rake'
  it_behaves_like 'including environment'

  it 'creates subscriptions for new users' do
    expect_any_instance_of(EmailDigests::CreateSubscriptions).to receive(:call)
    subject.invoke
  end
end

describe 'email_digests:send_weekly' do
  include_context 'rake'
  it_behaves_like 'including environment'

  it 'sends weekly email digests to users' do
    expect_any_instance_of(EmailDigests::SendWeekly).to receive(:call)
    subject.invoke
  end
end

describe 'email_digests:send_daily' do
  include_context 'rake'
  it_behaves_like 'including environment'

  it 'sends daily email digests to users' do
    expect_any_instance_of(EmailDigests::SendDaily).to receive(:call)
    subject.invoke
  end
end
