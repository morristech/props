FactoryGirl.define do
  factory :user do
    name FFaker::Name.name
    email FFaker::Internet.email
    provider 'provider'
    uid { FFaker::Guid.guid }
    pid '7fd72eff-f969-430d-8769-513adba5722c'
  end
end
