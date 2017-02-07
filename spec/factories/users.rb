FactoryGirl.define do
  factory :user do
    name FFaker::Name.name
    email FFaker::Internet.email
    provider 'provider'
    uid { FFaker::Guid.guid }
  end

  trait :with_proper_pid do
    pid '23cde420-cb83-4a26-868d-e4755526acad'
  end

  trait :with_wrong_pid do
    pid '23cde420-cb83-x-x-x'
  end
end
