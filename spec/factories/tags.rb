# -*- coding: utf-8 -*-

FactoryGirl.define do
  factory :tag, class: Tag do |f|
    f.name "test"
  end
  factory :name_empty, class: Tag do |f|
    f.name ""
  end
  factory :name, class: Tag do |f|
    f.name "navigation"
  end
  factory :name_max_length, class: Tag do |f|
    f.name "a" * 21
  end
  factory :name_full_width, class: Tag do |f|
    f.name "テスト"
  end
end
