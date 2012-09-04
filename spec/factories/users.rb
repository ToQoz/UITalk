# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :empty_user do
  end
  factory :user do |f|
    sequence(:name) { |n| "registered-user-#{n}" }
    sequence(:email) { |n| "registered-user-#{n}@example.com" }
    f.password "foobar"
    f.password_confirmation "foobar"
  end
  factory :user_with_twitter, class: User do |f|
    f.provider "twitter"
    sequence(:uid) { |n| "registered-user-with-twitter-#{n}" }
    sequence(:name) { |n| "registered-user-with-twitter-#{n}" }
    sequence(:email) { |n| "registered-user-with-twitter-#{n}@example.com" }
    f.password "foobar"
    f.password_confirmation "foobar"
  end
end
