# -*- coding: utf-8 -*-

# t.integer "post_id"
# t.integer "user_id"
# t.string  "kind"
# t.boolean "available"

class PostEvaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  attr_accessible :available, :post_id, :kind, :user_id

  validate :kind_valid?
  validates :user_id, :presence => true, :uniqueness => { :scope => :post_id, :message => "has already evaluated for this post" }

  default_scope where(available: true)
  scope :good, where(kind: '1')
  scope :bad, where(kind: '2')

  def evaluable_by?(post_id, user_id)
    PostEvaluation.find_by_post_id(post_id).user_id != user_id
  end

  include Evaluation
end
