FactoryGirl.define do
  factory :prop do
    body FFaker::Lorem.paragraph
    association :propser, factory: :user
    after :build do |prop|
      prop.prop_receivers.new(user: create(:user))
    end
  end
end
