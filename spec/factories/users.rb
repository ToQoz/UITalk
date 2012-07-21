# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "registered-#{n}" }
    sequence(:email) { |n| "registered-#{n}@example.com" }
  end
  factory :user_with_twitter, class: User do |f|
    f.provider "twitter"
    sequence(:uid) { |n| "registered-#{n}" }
    sequence(:name) { |n| "registered-#{n}" }
    sequence(:email) { |n| "registered-#{n}@example.com" }
  end
end
