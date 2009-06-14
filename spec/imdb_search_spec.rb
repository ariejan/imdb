require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Imdb::Search with multiple search results" do
  
  before(:each) do
    @search = Imdb::Search.new("Star Trek")
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
  
end

describe "Imdb::Search with an exact match" do
  
  before(:each) do
    @search = Imdb::Search.new("Matrix Revolutions")
  end
  
  it "should find one result" do
    @search.movies.size.should eql(1)
  end
  
  it "should have the corrected title" do
    @search.movies.first.title.should =~ /The Matrix Revolutions/i
  end
end
