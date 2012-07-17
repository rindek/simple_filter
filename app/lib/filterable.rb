module Filterable
  def filterable(condition)
    self.respond_to?("filter_#{condition}") ? self.send("filter_#{condition}") : self
  end

  module ClassMethods 
    def define_filters(hash)
      hash.each do |key, val|
        (class << self; self; end).send(:define_method, "filter_#{key}") do
          val.nil? ? self.where("") : (val[:action].is_a?(Symbol) ? self.send(val[:action]) : val[:action].call(self))
        end
      end

      (class << self; self; end).send(:define_method, "available_filters") do
        Hash[hash.map{|k, v| [k, (v.nil? or v[:label].nil?) ? k.to_s : v[:label]]}]
      end

      (class << self; self; end).send(:define_method, "filterable") do |arg|
        self.respond_to?("filter_#{arg}") ? self.send("filter_#{arg}") : (arg.nil? ? self.where("") : raise(Filterable::NoSuchFilterError, arg))
      end
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  class NoSuchFilterError < StandardError; end
end
