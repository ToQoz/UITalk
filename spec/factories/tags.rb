# -*- coding: utf-8 -*-

FactoryGirl.define do
  factory :name_empty, class: Tag do |f|
    f.name ""
  end
  factory :name, class: Tag do |f|
    f.name "navigation"
  end
  factory :name_max_length, class: Tag do |f|
    f.name "a" * 21
  end
end
