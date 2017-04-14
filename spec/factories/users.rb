FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "username_#{n}" }
    sequence(:email) { |n| "user_#{n}@email.com" }
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
