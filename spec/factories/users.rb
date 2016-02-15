FactoryGirl.define do
  factory :user do
    name FFaker::Name.name
    email FFaker::Internet.email
    provider 'provider'
    uid { FFaker::Guid.guid }
  end
end
