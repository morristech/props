FactoryGirl.define do
  factory :upvote do
    association :user, factory: :user
    association :prop, factory: :prop
  end
end
