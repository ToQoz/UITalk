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
      accessor_name = method_name.sub('increase_', '')
      if countable.include? accessor_name
        increase accessor_name rescue super
      else
        super
      end
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
