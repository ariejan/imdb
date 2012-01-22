module Imdb

  # Represents a Person on IMDB.com
  class Person
    attr_accessor :id, :url, :name

    # Initialize a new IMDB person object with it's IMDB id (as a String)
    #
    #   person = Imdb::Person.new("0000173")
    #
    # Imdb::Person objects are lazy loading, meaning that no HTTP request
    # will be performed when a new object is created. Only when you use an
    # accessor that needs the remote data, a HTTP request is made (once).
    #
    def initialize(imdb_id, name = nil)
      @id = imdb_id
      @url = "http://akas.imdb.com/name/nm#{imdb_id}"
      @name = name.gsub(/"/, "") if name
    end

    # Returns a string containing the name
    def name(force_refresh = false)
      if @name && !force_refresh
        @name
      else
        @name = document.at("h1").innerText.strip
      end
    end

    def birth_date
      document.search("time[@itemprop=birthDate]").map { |link| link.get_attribute("datetime").to_s }[0]
    end

    # Returns a new Hpricot document for parsing.
    def document
      @document ||= Hpricot(Imdb::Person.find_by_id(@id))
    end

    # Use HTTParty to fetch the raw HTML for this person.
    def self.find_by_id(imdb_id)
      open("http://akas.imdb.com/name/nm#{imdb_id}")
    end

  end # Person

end # Imdb
