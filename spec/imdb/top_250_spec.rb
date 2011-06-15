require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Imdb::Top250 do
  before(:each) do
    @movies = Imdb::Top250.new.movies
  end
  
  it "should be a list of movies" do
    @movies.each { |movie| movie.should be_an_instance_of(Imdb::Movie) }
  end
  
  it "should return the top 250 movies from IMDB.com" do
    @movies.size.should == 250
  end

  it "should provide array like access to the movies" do
    @first = @movies.first
    #@first.title.should == "The Shawshank Redemption" #not good as the titles are i18n
    @first.id.should == "0111161"
    @first.title.should_not be_empty
    @first.genres.should include("Drama")
  end
end
