# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post, class: Post do |f|
    f.title "MyString"
    f.body "MyString"
    f.image "MyString"
  end
end
