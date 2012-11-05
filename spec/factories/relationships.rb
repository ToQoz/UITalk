FactoryGirl.define do
  factory :following, class: User do |f|
    sequence(:name) { |n| "registered-following-for-rel#{n}" }
    sequence(:email) { |n| "registered-following-for-rel#{n}@example.com" }
    f.password "foobar"
    f.password_confirmation "foobar"
  end
  factory :follower, class: User do |f|
    sequence(:name) { |n| "registered-follower-for-rel#{n}" }
    sequence(:email) { |n| "registered-follower-for-rel#{n}@example.com" }
    f.password "foobar"
    f.password_confirmation "foobar"
  end
  factory :relationship, class: Relationship do |f|
    f.following_id 2
    f.follower_id 1
  end
end
