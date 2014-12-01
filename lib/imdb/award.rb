module Imdb
  class Award
    attr_accessor :name, :category, :winner, :nominees
    alias_method :winner?, :winner

    def initialize(name, options = {})
      @name = name
      @category = options[:category]
      @winner = options[:winner] || false
      @nominees = options[:nominees] || []
    end

    def eql?(other)
      @name == other.name && @category == other.category && @winner == other.winner && @nominees == other.nominees
    end
  end
end
