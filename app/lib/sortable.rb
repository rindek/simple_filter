module Sortable
  def sortable(sort)
    self.respond_to?("sortable_#{condition}") ? self.send("sortable_#{sort}") : self
  end

  module ClassMethods 
    def define_sorts(hash)
      (class << self; self; end).send(:define_method, "available_sorts") do
        hash.keys.map{|s| ["#{s}_asc", "#{s}_desc"]}.flatten
      end

      hash.each do |key, val|
        [:asc, :desc].each do |direction|
          (class << self; self; end).send(:define_method, "sort_#{key}_#{direction}") do
            val.is_a?(Symbol) ? self.order{val.send(direction)} : val[direction].call(self)
          end
        end
      end

      (class << self; self; end).send(:define_method, "sortable") do |arg|
        self.respond_to?("sort_#{arg}") ? self.send("sort_#{arg}") : (arg.nil? ? self.where("") : raise(Sortable::NoSuchSortError, arg))
      end
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  class NoSuchSortError < StandardError; end
end
