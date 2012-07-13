# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post, class: Post do |f|
    f.user_id "MyString"
    f.title "MyString"
    f.body "MyString"
  end
  factory :post_1, class: Post do |f|
    f.user_id "MyString"
    f.title "MyString"
    f.body "MyString"
  end
  factory :post_2, class: Post do |f|
    f.user_id "MyString"
    f.title "MyString"
    f.body "MyString"
  end
end
