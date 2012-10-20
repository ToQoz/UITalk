FactoryGirl.define do
  factory :stock, class: Stock do |s|
    s.user_id 1
    s.post_id 1
  end
  factory :stock_2, class: Stock do |s|
    s.user_id 1
    s.post_id 2
  end
  factory :stock_3, class: Stock do |s|
    s.user_id 1
    s.post_id 3
  end
end
