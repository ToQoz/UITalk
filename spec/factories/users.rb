# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :twitter_toqoz, class: User do |f|
    f.provider "twitter"
    f.uid "toqozuid"
    f.name "toqoz"
    f.email "toqoz@example.com"
  end
end
