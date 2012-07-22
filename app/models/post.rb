# -*- coding: utf-8 -*-

class Post < ActiveRecord::Base

  has_many :comments

  accepts_nested_attributes_for :comments

  attr_accessible :user_id, :title, :body

  scope :recent, lambda { |n| limit(n).order('created_at DESC, id DESC') }

  module ImageMethods
    def image_path
      "#{Rails.root}/public/uploaded/#{self.id.to_s}.png"
    end
    def set_image(image)
      File.open("#{image_path}", 'w').print(image.read.force_encoding('utf-8'))
    end
  end

  include ImageMethods

  def self.create_and_set_image(params, image)
    # TODO Error Handling
    post = self.new params
    post.save
    post.set_image(image)
    post
  end
end
