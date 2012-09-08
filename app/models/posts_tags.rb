# -*- coding: utf-8 -*-

# t.integer "post_id"
# t.integer "tag_id"
# t.boolean "available"

class PostsTags < ActiveRecord::Base
  has_many :posts
  has_many :tags

  attr_accessible :available, :post_id, :tag_id
end
