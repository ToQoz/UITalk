FactoryGirl.define do
  factory :post_evaluation do |f|
    f.good_count 0
    f.bad_count 0
    f.association :post, :factory => :post
  end
end
