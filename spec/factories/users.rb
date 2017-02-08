FactoryGirl.define do
  factory :user do
    name FFaker::Name.name
    email FFaker::Internet.email
    provider 'provider'
    uid { FFaker::Guid.guid }
  end

  trait :with_wrong_pid do
    pid 'xxx_wrong_pid_xxx'
  end
end
