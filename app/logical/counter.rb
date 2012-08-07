# -*- coding: utf-8 -*-

class NotCounterbleError < StandardError; end

module Counter

  module ClassMethods
    # class methods
  end

  def self.included(mod)
    mod.extend ClassMethods
  end

  def method_missing(name, *args, &block)
    method_name = name.to_s

    # use method missing for increase counter of various accessor
    if /^increase_/ =~ method_name
      attr = method_name.sub('increase_', '')
      increase attr
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
    raise NoMethodError, "undefined method `#{attr}` for #{self}" unless self.respond_to?(attr)
    raise NotCounterbleError, "not countable attributs `#{attr}` for #{self}" unless countable.include? attr
    self.send("#{attr}=", self.send(attr).send(:+, 1))
  end
end
