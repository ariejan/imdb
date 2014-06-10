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

    private

    # Returns a new Nokogiri document for parsing.
    def document
      @document ||= Nokogiri::HTML(Imdb::Person.find_by_id(@id))
    end

    # Use HTTParty to fetch the raw HTML for this person.
    def self.find_by_id(imdb_id)
      open("http://akas.imdb.com/name/nm#{imdb_id}")
    end

  end # Person
end # Imdb
