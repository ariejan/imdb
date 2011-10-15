module Imdb
  
  class Episode
    
    attr_accessor :title, :synopsis, :number, :release_date
    
    def initialize(number, node, season)
      @number = number
      @node = node
      @season = season
    end

    def title
      @node.search('table tr td h3 a').innerHTML.imdb_unescape_html rescue nil
    end
    
    def synopsis
      @node.search('table tr td/text()').text rescue nil
    end
    
    def release_date
      @node.search('table tr td span strong').innerHTML.imdb_unescape_html rescue nil
    end
    
  end  #Episode
end # Imdb
