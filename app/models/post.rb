# -*- coding: utf-8 -*-

class Post < ActiveRecord::Base

  has_many :comments
  has_many :posts_tags
  has_many :tags, :through => :posts_tags

  accepts_nested_attributes_for :comments

  attr_accessor :image, :tags_str
  attr_accessible :user_id, :title, :body, :image, :tags_str

  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :body, :presence => true, :length => { :maximum => 1500 }

  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :body, :presence => true, :length => { :maximum => 1500 }

  scope :recent, lambda { |n| limit(n).order('created_at DESC, id DESC') }

  before_save :create_tags
  after_save :create_posts_tags
  after_save :set_image

  module ImageMethods
    def image_path
      "#{Rails.root}/public/uploaded/#{self.id.to_s}.png"
    end
    def set_image
      if image
        File.open("#{image_path}", 'w').print(image.read.force_encoding('utf-8'))
      end
    end
  end

  module TagMethods
    def to_tag_array
      @tag_array ||= Tag.to_tag_array(tags_str)
    end
    def create_tags
      to_tag_array.map {|x| Tag.find_or_create_by_name(x)}
    end
  end

  module PostsTagsMethods
    def create_posts_tags
      to_tag_array.each{|x|
        PostsTags.new.tap do |pt|
          pt.tag_id = Tag.find_by_name(x).id
          pt.post_id = self.id
          pt.save
        end
      }
    end
  end

  include ImageMethods
  include TagMethods
  include PostsTagsMethods

end
