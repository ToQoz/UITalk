# -*- coding: utf-8 -*-

class Tag < ActiveRecord::Base

  has_many :posts_tags
  has_many :posts, :through => :posts_tags

  attr_accessible :available, :name

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 20 }

  validates_format_of :name, :with => /^[ -~｡-ﾟ]*$/

  scope :name_is, lambda { |name| where(["lower(name) = ?", name.downcase]) }

  def self.names
    scoped.map { |tag| tag.name }
  end

  #custome setter
  def name=(value)
    if value.is_a?(String)
      write_attribute(:name, self.class.normalize(value))
    end
  end

  def to_param
    name.parameterize
  end

  module NameMethods
    module ClassMethods
      def find_or_create_by_name(name)
        tag = find_by_name(name)
        if tag
          tag
        else
          Tag.new.tap do |t|
            t.name = name
            t.save
          end
        end
      end
    end
    def self.included(m)
      m.extend(ClassMethods)
    end
  end

  module ParseMethods
    def normalize(query)
      query.to_s.downcase.strip
    end
    def to_tag_array(tags_str)
      normalize(tags_str).split(",").uniq
    end
  end

  include NameMethods
  extend ParseMethods

end
