FactoryGirl.define do
  factory :stock, class: Stock do |s|
    s.user_id 1
    sequence(:post_id) { |n| n }
  end
  factory :other_user_stock, class: Stock do |s|
    s.user_id 2
    s.post_id 1
  end
end
