require 'spec_helper'

describe "Imdb::Search with multiple search results" do
  
  before(:each) do
    @search = Imdb::Search.new("Star Trek")
  end

  it "should remember the query" do
    @search.query.should == "Star Trek"
  end
  
  it "should find > 10 results" do
    @search.movies.size.should > 10
  end
  
  it "should return Imdb::Movie objects only" do
    @search.movies.each { |movie| movie.should be_an(Imdb::Movie) }
  end
  
  it "should not return movies with no title" do
    @search.movies.each { |movie| movie.title.should_not be_blank }
  end
  
  it "should return only the title of the result" do
    @search.movies.first.title.should eql("Star Trek (1966) (TV series)")
  end
  
  it "should return aka titles as well" do
    alt_titles = [
      '"Star Trek: TOS" - USA (promotional abbreviation)',
      '"Star Trek: The Original Series" - USA (informal title)',
      '"Viaje a las estrellas" - Argentina, Mexico',
      '"Jornada nas Estrelas" - Brazil',
      '"La conquista del espacio" - Spain',
      '"La patrouille du cosmos" - Canada (French title)',
      '"Raumschiff Enterprise" - West Germany',
      '"Star Trek" - France',
      '"Star Trek" - Greece',
      '"Star Trek" - Italy',
      '"Star Trek: The Original Series" - Spain',
      '"Uchuu Daisakusen" - Japan (first season title)',
      '"Uzay yolu" - Turkey (Turkish title)']
      
    alt_titles.each { |aka| @search.movies.first.also_known_as.should include(aka) }
  end
  
end

describe "Imdb::Search with an exact match and no poster" do
  
  it "should not raise an exception" do
    lambda {
      @search = Imdb::Search.new("Kannethirey Thondrinal").movies
    }.should_not raise_error
  end
  
  it "should return the movie id correctly" do
    @search = Imdb::Search.new("Kannethirey Thondrinal")
    @search.movies.first.id.should eql("0330508")
  end
  
end

describe "Imdb::Search with an exact match" do
  
  before(:each) do
    @search = Imdb::Search.new("I killed my lesbian wife")
  end
  
  it "should find one result" do
    @search.movies.size.should eql(1)
  end
  
  it "should have the corrected title" do
    @search.movies.first.title.should =~ /I Killed My Lesbian Wife/i
  end
end
