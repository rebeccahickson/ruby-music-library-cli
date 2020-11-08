require 'pry'
require_relative 'basics'
require_relative 'finder'

class Genre
  include Basics::InstanceMethods
  extend Basics::ClassMethods
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    @@all << self
  end

  def add_song(song)
    song.genre = self if song.genre.nil?
    @songs << song unless @songs.any?(song)
  end

  def artists
    Artist.all.select do |type|
      type.songs.map do |song|
        song.genre == self
      end
    end
  end

  def self.all
    @@all
  end
end
