# -*- coding: utf-8 -*-

class Tag < ActiveRecord::Base

  attr_accessible :available, :name

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 20 }

end
