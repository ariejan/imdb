require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

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
  
  it "should set the title of the movie" do
    @search.movies.first.title.should_not be_nil
  end
  
  it "should extract the title correctly (no aka)" do
    @search.movies.each do |movie|
      movie.title.should_not match(/\saka\s/)
    end
  end
  
end

describe "Imdb::Search with an exact match" do
  
  it "should not raise an exception" do
    lambda {
      @search = Imdb::Search.new("Kannethirey Thondrinal").movies
    }.should_not raise_error
  end
  
  it "should return the movie id correctly" do
    @search = Imdb::Search.new("Kannethirey Thondrinal")
    @search.movies.first.id.should eql("0330508")
  end

  it "should have one movie" do  
    @search = Imdb::Search.new("Kannethirey Thondrinal")
    @search.movies.size.should == 1
  end
end

