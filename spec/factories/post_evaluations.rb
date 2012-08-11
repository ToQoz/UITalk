FactoryGirl.define do
  factory :good_kind_post_eval, class: PostEvaluation do |f|
    f.kind "1"
    f.association :user, :factory => :user_with_twitter
    f.association :post, :factory => :post
  end
  factory :bad_kind_post_eval, class: PostEvaluation do |f|
    f.kind "2"
    f.association :user, :factory => :user_with_twitter
    f.association :post, :factory => :post
  end
  factory :invalid_kind_post_eval, class: PostEvaluation do |f|
    f.kind "3"
    f.association :user, :factory => :user_with_twitter
    f.association :post, :factory => :post
  end
end
