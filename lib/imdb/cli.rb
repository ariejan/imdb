require 'optparse'

module Imdb
  class CLI
    
    # Run the imdb command
    #
    # Searching
    #
    #   imdb Star Trek
    #
    # Get a movie, supply a 7 digit IMDB id
    #
    #   imdb 0095016
    #
    def self.execute(stdout, arguments=[])
      
      @stdout = stdout
      
      options = {
      }
      mandatory_options = %w(  )
      
      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          IMDB #{Imdb::VERSION}

          Usage: #{File.basename($0)} Search Query
                 #{File.basename($0)} 0095016

        BANNER
        opts.separator ""
        opts.on("-v", "--version",
                "Show the current version.") { stdout.puts "IMDB #{Imdb::VERSION}"; exit }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      query = arguments.join(" ").strip
      exit if query.blank?
      
      movie, search = nil, nil
      
      # If ID, fetch movie
      if query.match(/\d\d\d\d\d\d\d/)
        fetch_movie(query)
      else
        search_movie(query)
      end
    end
    
    def self.fetch_movie(imdb_id)
      @stdout.puts ">> Fetching movie #{imdb_id}"
      
      movie = Imdb::Movie.new(imdb_id)
      
      display_movie_details(movie)
    end
    
    def self.search_movie(query)
      @stdout.puts ">> Searching for \"#{query}\""
      
      search = Imdb::Search.new(query)
      
      if search.movies.size == 1
        display_movie_details(search.movies.first)
      else
        display_search_results(search.movies)
      end
    end
    
    def self.display_movie_details(movie)
      @stdout.puts
      @stdout.puts "#{movie.title} (#{movie.year})"
      @stdout.puts "=" * 72
      @stdout.puts "Rating: #{movie.rating}"
      @stdout.puts "Duration: #{movie.length} minutes"
      @stdout.puts "Directed by: #{movie.director.join(", ")}"
      @stdout.puts "Cast: #{movie.cast_members[0..4].join(", ")}"
      @stdout.puts "Genre: #{movie.genres.join(", ")}"
      @stdout.puts "#{movie.plot}"
      @stdout.puts "=" * 72
      @stdout.puts
    end
    
    def self.display_search_results(movies = [])
      movies = movies[0..9] # limit to ten top hits
      
      movies.each do |movie|
        @stdout.puts " > #{movie.id} | #{movie.title}"
      end
    end
    
  end
end