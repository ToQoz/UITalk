FactoryGirl.define do
  factory :comment, class: Comment do |f|
    f.user_id "MyString"
    f.post_id "MyString"
    f.body "MyString"
  end
end
