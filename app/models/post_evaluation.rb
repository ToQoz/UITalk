# -*- coding: utf-8 -*-

# t.integer "post_id"
# t.integer "good_count"
# t.integer "bad_count"
# t.boolean "available"

class PostEvaluation < ActiveRecord::Base
  belongs_to :post

  attr_accessible :post_id, :good_count, :bad_count, :available

  include Counter

  def total
    good_count - bad_count
  end

  def countable
    [ 'good_count', 'bad_count' ]
  end
end
