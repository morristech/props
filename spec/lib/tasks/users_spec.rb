require 'rails_helper'

describe 'users:archive' do
  include_context 'rake'
  let(:email) { 'test@example.com' }
  let!(:user) { create(:user, email: email) }

  it 'archives user with a given email' do
    expect_any_instance_of(Users::ArchiveUser).to receive(:call)
    subject.invoke(email)
  end
end
