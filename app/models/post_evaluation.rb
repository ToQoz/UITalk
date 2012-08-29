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

  default_scope where(available: true)
  scope :good, where(kind: '1')
  scope :bad, where(kind: '2')

  include Evaluation
end
