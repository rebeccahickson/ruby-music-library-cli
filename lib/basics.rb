require 'pry'

module Basics
  module InstanceMethods
    def initialize(name, _optional_artist = nil, _optional_genre = nil)
      @name = name
    end

    def save
      self.class.all << self
    end
  end

  module ClassMethods
    def destroy_all
      all.clear
    end

    def create(name)
      new(name)
    end
  end
end
