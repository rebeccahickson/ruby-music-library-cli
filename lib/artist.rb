require 'pry'
require_relative 'basics'
require_relative 'finder'

class Artist
  include Basics::InstanceMethods
  extend Basics::ClassMethods
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    super
    @songs = []
    @@all << self
  end

  def add_song(song)
    song.artist = self if song.artist.nil?
    @songs << song unless @songs.any?(song)
  end

  def genres
    Genre.all.select do |type|
      type.songs.map do |song|
        song.artist == self
      end
    end
  end

  def self.all
    @@all
  end
end
