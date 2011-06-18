require 'optparse'

module Imdb
  class CLI
    
    # Run the imdb command
    #
    # Searching
    #
    #   imdb Star Trek
    #
    # Get a movie, supply a 7 digit IMDB id or the IMDB URL
    #
    #   imdb 0095016
    #   imdb http://www.imdb.com/title/tt0796366/
    #
    def self.execute(stdout, arguments=[])
      
      @stdout = stdout
      
      @stdout.puts "IMDB Scraper #{Imdb::VERSION}"
      
      options = {
      }
      mandatory_options = %w(  )
      
      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')          

Usage: #{File.basename($0)} Search Query
       #{File.basename($0)} 0095016

        BANNER
        opts.separator ""
        opts.on("-v", "--version",
                "Show the current version.") { stdout.puts "IMDB #{Imdb::VERSION}"; exit }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.on("-l", "--locale LOCALE", String,
                "Language (de,en,de-de)") { |_locale| Imdb::Config.accept_language = _locale }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      query = arguments.join(" ").strip
      exit if query.blank?
      
      movie, search = nil, nil
      
      # If ID, fetch movie
      if query.match(/(\d\d\d\d\d\d\d)/) || query.downcase.match(/^http:\/\/[www.]*imdb.com\/title\/tt(.+)\/$/)
        fetch_movie($1)
      else
        search_movie(query)
      end
    end
    
    def self.fetch_movie(imdb_id)
      @stdout.puts
      @stdout.puts " - fetching movie #{imdb_id}"
      
      movie = Imdb::Movie.new(imdb_id)
      
      display_movie_details(movie)
    end
    
    def self.search_movie(query)
      @stdout.puts
      @stdout.puts " - searching for \"#{query}\""
      
      search = Imdb::Search.new(query)
      
      if search.movies.size == 1
        display_movie_details(search.movies.first)
      else
        display_search_results(search.movies)
      end
    end
    
    def self.display_movie_details(movie)
      title = "#{movie.title} (#{movie.year})"
      id    = "ID #{movie.id}"
      
      @stdout.puts "Locale: #{Imdb::Config.accept_language}"
      @stdout.puts "#{title}#{" " * (75 - 1 - title.length - id.length)}#{id} "
      @stdout.puts "=" * 75
      @stdout.puts "Original title: #{movie.original_title}"
      @stdout.puts "Rating: #{movie.rating}"
      @stdout.puts "Duration: #{movie.length} minutes"
      @stdout.puts "Directed by: #{movie.director.join(", ")}"
      @stdout.puts "Cast: #{movie.cast_members[0..4].join(", ")}"
      @stdout.puts "Genre: #{movie.genres.join(", ")}"
      @stdout.puts "Plot: #{movie.plot}"
      @stdout.puts "Poster URL: #{movie.poster}"
      @stdout.puts "IMDB URL: #{movie.url}"
      @stdout.puts "=" * 75
      @stdout.puts
    end
    
    def self.display_search_results(movies = [])
      movies = movies[0..9] # limit to ten top hits
      
      movies.each do |movie|
        @stdout.puts " > #{movie.id} | #{movie.title} (#{movie.year})"
      end
    end
    
  end
end