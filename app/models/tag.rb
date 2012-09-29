# -*- coding: utf-8 -*-

class Tag < ActiveRecord::Base

  has_many :posts_tags
  has_many :posts, :through => :posts_tags

  attr_accessible :available, :name

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 20 }

  validates_format_of :name, :with => /^[ -~｡-ﾟ]*$/

  scope :name_is, lambda { |name| where(["lower(name) = ?", name.downcase]) }

end
