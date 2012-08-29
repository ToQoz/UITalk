# -*- coding: utf-8 -*-

module Evaluation

   module ClassMethods
     # class methods
   end

   def self.included(base)
     base.extend ClassMethods
   end

   def kind_list
     # 1: good
     # 2: bad
     [ 1, 2 ]
   end

   def include_by_kind?
     kind_list.include? kind
   end

   def kind_valid?
     errors.add(:kind, 'kindが不正') unless include_by_kind?
   end
end
