# -*- coding: utf-8 -*-

# t.integer "post_id"
# t.integer  "count"
# t.boolean "available"

class PostEvaluation < ActiveRecord::Base
  belongs_to :post

  attr_accessible :post_id, :good_count, :bad_count, :available

  def total
    good_count - bad_count
  end

  def method_missing(name, *args, &block)
    method_name = name.to_s

    # use method missing for increase counter of various accessor
    if /^increase_/ =~ method_name
      increase method_name.sub('increase_', '') rescue super
    elsif
      super
    end
  end

  private
  # Private: increase counter of various attributes
  #
  # attr - A Sring with this class accessable attribute
  #
  # Returns instance of this class for metod chain
  def increase(attr)
    self.send("#{attr}=", self.send(attr).send(:+, 1))
    self
  end
end
