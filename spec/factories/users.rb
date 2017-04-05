FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "username_#{n}"
    end
    sequence :email do |n|
      "user_#{n}@email.com"
    end
    provider 'provider'
    uid { FFaker::Guid.guid }
  end
end
