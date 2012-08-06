# -*- coding: utf-8 -*-

# t.integer "post_id"
# t.integer  "count"
# t.boolean "available"

class PostEvaluation < ActiveRecord::Base
  attr_accessible :available, :count, :post_id
end
