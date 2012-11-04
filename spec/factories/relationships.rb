FactoryGirl.define do
  factory :relationship, class: Relationship do |r|
    r.following_id 2
    r.follower_id 1
  end
end
