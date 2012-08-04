# -*- coding: utf-8 -*-

class Comment < ActiveRecord::Base

  belongs_to :post

  attr_accessible :available, :body, :post_id, :user_id

  validates :body, :presence => true, :length => { :maximum => 1500 }
  validates :post_id, :presence => true
  validates :user_id, :presence => true

  scope :recent, lambda { |n| order('created_at DESC').limit(n) }

end
