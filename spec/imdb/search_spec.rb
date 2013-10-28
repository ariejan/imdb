require 'spec_helper'

describe "Imdb::Search with multiple search results" do

  before(:each) do
    @search = Imdb::Search.new("Star Trek: TOS")
  end

  it "should remember the query" do
    @search.query.should == "Star Trek: TOS"
  end

  it "should find 2 results" do
    @search.movies.size.should eql(2)
  end

  it "should return Imdb::Movie objects only" do
    @search.movies.each { |movie| movie.should be_an(Imdb::Movie) }
  end

  it "should not return movies with no title" do
    @search.movies.each { |movie| movie.title.should_not be_blank }
  end

  it "should return only the title of the result" do
    @search.movies.first.title.should eql("Star Trek (1966) (TV Series)")
  end
end

describe "Imdb::Search with an exact match and no poster" do

  it "should not raise an exception" do
    expect {
      @search = Imdb::Search.new("Kannethirey Thondrinal").movies
    }.not_to raise_error
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
