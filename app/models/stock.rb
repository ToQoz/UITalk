# -*- coding: utf-8 -*-

class Stock < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

  attr_accessible :available, :post_id, :user_id

  validates :post_id, :presence => true, :uniqueness => true
  validates :user_id, :presence => true

end
