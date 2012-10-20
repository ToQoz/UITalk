# -*- coding: utf-8 -*-

class Stock < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

  attr_accessible :available, :post_id, :user_id

  validates :post_id, :presence => true
  validates :user_id, :presence => true

  scope :for_user, lambda {|user_id| where("user_id = #{user_id.to_i}")}
  scope :recent, lambda { |n| limit(n).order('created_at DESC, id DESC') }
end
