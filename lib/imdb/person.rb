module Imdb
  # Represents someone on IMDB.com
  class Person
    attr_accessor :id, :url, :name

    # Initialize a new IMDB person object with it's IMDB id (as a String)
    #
    #   person = Imdb::Person.new("0000246")
    #
    # Imdb::Person objects are lazy loading, meaning that no HTTP request
    # will be performed when a new object is created. Only when you use an
    # accessor that needs the remote data, a HTTP request is made (once).
    #
    def initialize(imdb_id, name = nil)
      @id = imdb_id
      @url = "http://akas.imdb.com/name/nm#{imdb_id}"
      @name = name.gsub(/"/, '').strip if name
    end

    # Returns a string containing the name
    def name(force_refresh = false)
      if @name && !force_refresh
        @name
      else
        @name = document.at('h1').text.strip rescue nil
      end
    end

    # Returns a string containing the birthdate
    def birthdate
      document.css('time[itemprop=birthDate]').text.delete("\n").squeeze("\s").strip
    end

    # Returns an integer containing the age
    def age
      Date.today.year - birthdate[/\d+$/].to_i
    end

    # Returns array of work categories exercised by person, e.g. actor, director, etc.
    def categories
      document.css('#jumpto a').map(&:text)
    end

    # Returns array of movies with person in some category, e.g. as an actor, director, etc.
    def movies_as(category)
      movies = document.css("#filmo-head-#{category}").first.next_element.children.to_a
      movies.reject! { |movie| movie.class == Nokogiri::XML::Text }
      movies.map do |movie|
        movie_id = movie.attr('id')[/\d+/]
        Movie.new(movie_id)
      end
    end

    private

    # Returns a new Nokogiri document for parsing.
    def document
      @document ||= Nokogiri::HTML(Imdb::Person.find_by_id(@id))
    end

    # Use HTTParty to fetch the raw HTML for this person.
    def self.find_by_id(imdb_id)
      open("http://akas.imdb.com/name/nm#{imdb_id}")
    end

    # Dynamic aliasing for movies_as method. e.g. movies_as_actor equals movies_as(:actor)
    def method_missing(method_name, *args)
      get_movies = method_name.to_s.match(/^movies_as_(.+)$/)
      category = get_movies[1] if get_movies
      if get_movies && categories.map(&:downcase).include?(category.gsub(/_/, ' '))
        movies_as category
      else
        super
      end
    end
  end # Person
end # Imdb
