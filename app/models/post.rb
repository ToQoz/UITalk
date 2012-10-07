# -*- coding: utf-8 -*-

class Post < ActiveRecord::Base

  has_many :comments
  has_many :posts_tags
  has_many :tags, :through => :posts_tags

  accepts_nested_attributes_for :comments

  attr_accessible :user_id, :title, :body

  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :body, :presence => true, :length => { :maximum => 1500 }

  scope :recent, lambda { |n| limit(n).order('created_at DESC, id DESC') }

  module ImageMethods
    def image_path
      "#{Rails.root}/public/uploaded/#{self.id.to_s}.png"
    end
    def set_image
      File.open("#{image_path}", 'w').print(image.read.force_encoding('utf-8'))
    end
  end

  include ImageMethods

  def self.create_and_set_image(params, image)
    self.transaction do
      begin
        post = self.new params
        post.save
        if image
          post.set_image(image)
        end
      rescue => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join("\n")

        raise ActiveRecord::Rollback
      end
    end
  end

end
