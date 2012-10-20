FactoryGirl.define do
  factory :stock, class: Stock do |s|
    s.user_id 1
    s.post_id 1
  end
end
