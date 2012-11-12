# -*- coding: utf-8 -*-

# t.integer "comment_id"
# t.integer "user_id"
# t.string  "kind"
# t.boolean "available"

class CommentEvaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment

  attr_accessible :available, :comment_id, :kind, :user_id

  validate :kind_valid?
  validates :user_id, :presence => true, :uniqueness => { :scope => :comment_id, :message => "has already evaluated for this comment" }

  default_scope where(available: true)
  scope :good, where(kind: 1)
  scope :bad, where(kind: 2)

  def evaluable_by?(comment_id, user_id)
    CommentEvaluation.find_by_comment_id(comment_id).user_id != user_id
  end

  include Evaluation
end
