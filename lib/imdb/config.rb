module Imdb
  module Config
    def self.accept_language
        Thread.current["imdb_config_accept_language"] || "en"
    end
    def self.accept_language=(_al)
      Thread.current["imdb_config_accept_language"]=_al
    end
  end
end
