require 'pry'

class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    file_list = Dir["#{@path}/*"]
    trimmed_files = file_list.map do |item|
      item.slice!('./spec/fixtures/mp3s/')
      item
    end
  end

  def import
    files.each { |file| Song.create_from_filename(file) }
  end
end
