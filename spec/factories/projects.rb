FactoryGirl.define do
  factory :user_for_project, class: User do |f|
    sequence(:name) { |n| "registered-user-for-project#{n}" }
    sequence(:email) { |n| "registered-user-for-project#{n}@example.com" }
    f.password "foobar"
    f.password_confirmation "foobar"
  end

  factory :project, class: Project do |f|
    sequence(:name) { |n| "registered-#{n}" }
    f.owner_id 1
    f.is_public false
    f.available true
    f.users { |p| [ p.association(:user_for_project) ] }
  end

  factory :public_project, class: Project do |f|
    sequence(:name) { |n| "registered-#{n}" }
    f.owner_id 1
    f.is_public true
    f.available true
  end
end
