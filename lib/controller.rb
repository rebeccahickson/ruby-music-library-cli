class MusicLibraryController
  attr_reader :path, :song_list

  def initialize(path = './db/mp3s')
    @path = path
    @song_list = MusicImporter.new(path).import
  end
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/AbcSize
  def call
    puts 'Welcome to your music library!'
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts 'What would you like to do?'
    input = gets.strip
    case input
    when 'list songs'
      list_songs
    when 'list artists'
      list_artists
    when 'list genres'
      list_genres
    when 'list artist'
      list_songs_by_artist
    when 'list genre'
      list_songs_by_genre
    when 'play song'
      play_song
    when 'exit'
      nil
    else call
    end
  end

  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/AbcSize

  def list_songs
    new_arr = @song_list.sort_by { |song| song.partition(' - ')[2] }.map { |song| song.slice(song.index(/[A-Z]/)..-5) }
    new_arr.each_with_index { |song, index| puts "#{index + 1}. #{song}" }
  end

  def list_artists
    arr = []
    Artist.all.map { |artist| arr << artist.name }
    arr.sort.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.slice(artist.index(/[A-Z]/)..-1)}"
    end
  end

  def list_genres
    arr = []
    Genre.all.map { |genre| arr << genre.name }
    arr.sort.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre}"
    end
  end

  # rubocop:disable Metrics/AbcSize

  def list_songs_by_artist
    puts 'Please enter the name of an artist:'
    artist_name = gets.strip
    artist_songs = Song.all.select { |song| song.artist.name == artist_name }
    return if artist_songs.nil?

    cleaned_list = []
    artist_songs.map do |song|
      cleaned_list << "#{song.name} - #{song.genre.name}"
    end
    cleaned_list.uniq.sort.each_with_index { |song, index| puts "#{index + 1}. #{song}" }
  end

  def list_songs_by_genre
    puts 'Please enter the name of a genre:'
    genre_name = gets.strip
    genre_songs = Song.all.select { |song| song.genre.name == genre_name }
    return if genre_songs.nil?

    cleaned_list = []
    genre_songs.map do |song|
      cleaned_list << "#{song.artist.name} - #{song.name}"
    end
    cleaned_list.uniq.sort_by { |song| song.partition(' - ')[2] }.each_with_index { |song, index| puts "#{index + 1}. #{song}" }
  end

  def play_song
    puts 'Which song number would you like to play?'
    input = gets.strip.to_i
    return unless input.between?(1, @song_list.length)

    new_arr = @song_list.sort_by { |song| song.partition(' - ')[2] }
    puts "Playing #{new_arr[input - 1].partition(' - ')[2].partition(' - ')[0]} by #{new_arr[input - 1].partition(' - ')[0]}"
  end

  # rubocop:enable Metrics/AbcSize
end
