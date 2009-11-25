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

    # Strips out whitespace then tests if the string is empty.
    def blank?
      strip.empty?
    end unless method_defined?(:blank?)
  end
end

String.send :include, Imdb::StringExtensions
