# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :empty_user do
  end
  factory :user do |f|
    sequence(:name) { |n| "registered-#{n}" }
    sequence(:email) { |n| "registered-#{n}@example.com" }
    f.password "foobar"
    f.password_confirmation "foobar"
  end
  factory :user_with_twitter, class: User do |f|
    f.provider "twitter"
    sequence(:uid) { |n| "registered-#{n}" }
    sequence(:name) { |n| "registered-#{n}" }
    sequence(:email) { |n| "registered-#{n}@example.com" }
    f.password "foobar"
    f.password_confirmation "foobar"
  end
end
