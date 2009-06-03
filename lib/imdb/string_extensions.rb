require 'cgi'
require 'iconv'

 
module Imdb #:nordoc:
  module StringExtensions
  
    # Unescape HTML
    def imdb_unescape_html
      Iconv.conv("UTF-8", 'ISO-8859-1', CGI::unescapeHTML(self))
    end
  
    # Strip tags
    def imdb_strip_tags
      gsub(/<\/?[^>]*>/, "")
    end
  end
end

String.send :include, Imdb::StringExtensions