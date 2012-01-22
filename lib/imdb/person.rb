module Imdb

  # Represents a Person on IMDB.com
  class Person
    attr_accessor :id, :url, :name, :movies

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
      @url = "http://akas.imdb.com/name/nm#{imdb_id}/"
      @name = name.gsub(/"/, "") if name
      @movies = nil
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

    def roles
      rolestring = document.search("div[@class=infobar]").map { |link| link.innerText }
      roles = rolestring[0].split("|")
      roles.map { |r| r.strip.gsub(/[^\ A-Za-z]/, '') }
    end

    def filmography_types
      typesstring = document.search("div[@id=jumpto]").map { |link| link.innerText }[0]
      typesstring.sub!(/Jump to:/, '')

      types = typesstring.split("|")
      types.map { |r| r.gsub!(/\n/, '') }
      types.map { |r| r.gsub!(/[^A-Za-z]/, ' ') }
      types
    end

    def filmography(filter_type = nil, force_reload = nil)
      if (!@movies.nil? and force_reload.nil?)
        if (filter_type.nil?)
          array = []
          @movies.each_key { |k|
            @movies[k].each { |f|
              array.push f
            }
          }
          return array
        else
          @movies[filter_type] || []
        end
      else
        @movies = {}
        sections = filmography_doc.search("div[@class=filmo]")
        sections.each { |s|
          type = s.at("h5").innerText.strip.sub(":", '').sub(/ -.*/, '')
          @movies[type] ||= []

          films = s.search("a[@href*=title/tt]")
          films.each { |f|
            title = f.innerText.strip
            id = f.get_attribute("href").split("/")[2].sub("tt", "")
            film = Imdb::Movie.new(id, title)
            @movies[type].push(film)
          }
        }
        if (filter_type.nil?)
          array = []
          @movies.each_key { |k|
            @movies[k].each { |f|
              array.push f
            }
          }
          return array
        else
          @movies[filter_type] || []
        end
      end
    end

    # Returns a new Hpricot document for parsing.
    def document
      @document ||= Hpricot(Imdb::Person.get_page_by_id(@id))
    end

    # Use HTTParty to fetch their filmography page
    def filmography_doc
      @film_doc ||= Hpricot(Imdb::Person.get_page_by_id(@id, "filmotype")) 
    end

    # Use HTTParty to fetch the raw HTML for this person.
    def self.get_page_by_id(imdb_id, subpage = nil)
      url = "http://akas.imdb.com/name/nm#{imdb_id}/"
      url += subpage unless subpage.nil?
      open(url)
    end

    def self.find_by_id(imdb_id)
      open("http://akas.imdb.com/name/nm#{imdb_id}/")
    end

  end # Person

end # Imdb
