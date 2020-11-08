require 'pry'
require_relative 'basics'
require_relative 'finder'

class Song
  include Basics::InstanceMethods
  extend Basics::ClassMethods
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    super
    self.artist = (artist) unless artist.nil?
    self.genre = (genre) unless genre.nil?
    @@all << self
  end

  def artist=(artist_name)
    @artist = artist_name
    artist.add_song(self)
  end

  def genre=(genre_type)
    @genre = genre_type
    genre.add_song(self)
  end

  def self.new_from_filename(file)
    arr = file.split(' - ')
    current_artist = Artist.find_or_create_by_name(arr[0])
    current_genre = Genre.find_or_create_by_name(arr[2].chomp('.mp3'))
    new(arr[1], current_artist, current_genre)
  end

  def self.create_from_filename(file)
    new_song = new_from_filename(file)
    new_song.save
  end

  def self.all
    @@all
  end
end
