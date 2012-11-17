# -*- coding: utf-8 -*-

class Stock < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

  attr_accessible :post_id, :user_id

  validates :post_id, :presence => true, :uniqueness => { :scope => :user_id, :message => "has already stocked for this post" }
  validates :user_id, :presence => true

  scope :for_user, lambda {|user_id| where("user_id = #{user_id.to_i}")}
  scope :recent, lambda { |n| limit(n).order('created_at DESC, id DESC') }

  def editable_by?(user_id, stocked_user_id)
    user_id == stocked_user_id
  end
end
