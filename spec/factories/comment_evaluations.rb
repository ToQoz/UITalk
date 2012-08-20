FactoryGirl.define do
  factory :good_kind_comment_eval, class: CommentEvaluation do |f|
    f.kind 1
    f.association :user, :factory => :user_with_twitter
    f.association :comment, :factory => :comment
  end
  factory :bad_kind_comment_eval, class: CommentEvaluation do |f|
    f.kind 2
    f.association :user, :factory => :user_with_twitter
    f.association :comment, :factory => :comment
  end
  factory :invalid_kind_comment_eval, class: CommentEvaluation do |f|
    f.kind 3
    f.association :user, :factory => :user_with_twitter
    f.association :comment, :factory => :comment
  end
end
