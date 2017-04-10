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

    trait :with_organisation do
      after(:create) do |user|
        organisation = create :organisation
        user.organisations << organisation
      end
    end
  end
end
