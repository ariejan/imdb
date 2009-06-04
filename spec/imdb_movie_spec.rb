require File.dirname(__FILE__) + '/spec_helper.rb'

### WARNING: This spec uses live data!
#
# Many may object to testing against a live website, and for good reason. 
# However, the IMDB interface changes over time, and to guarantee the parser
# works with the currently available IMDB website, tests are run against
# IMDB.com instead.
#
# This test uses "Die hard (1988)" as a testing sample:
#   
#     http://www.imdb.com/title/tt0095016/
#

describe "Imdb::Movie" do
  
  before(:each) do
    # Get Die Hard (1988)
    @movie = Imdb::Movie.new("0095016")
  end
  
  it "should find the cast members" do
    cast = @movie.cast_members
    
    cast.should be_an(Array)
    cast.should include("Bruce Willis")
    cast.should include("Bonnie Bedelia")
    cast.should include("Alan Rickman")
  end
  
  it "should find the director" do
    @movie.director.should be_an(Array)
    @movie.director.size.should eql(1)
    @movie.director.first.should =~ /John McTiernan/
  end
  
  it "should find the genres" do
    genres = @movie.genres
    
    genres.should be_an(Array)
    genres.should include('Action')
    genres.should include('Crime')
    genres.should include('Drama')
    genres.should include('Thriller')
  end
  
  it "should find the length (in minutes)" do
    @movie.length.should eql(131)
  end
  
  it "should find the plot" do
    @movie.plot.should eql("New York cop John McClane gives terrorists a dose of their own medicine as they hold hostages in an LA office building.")
  end
  
  it "should find the poster" do
    @movie.poster.should eql("http://ia.media-imdb.com/images/M/MV5BMTIxNTY3NjM0OV5BMl5BanBnXkFtZTcwNzg5MzY0MQ@@.jpg")
  end
  
  it "should find the rating" do
    @movie.rating.should eql(8.3)
  end
  
  it "should find the title" do
    @movie.title.should =~ /Die Hard/
  end
  
  it "should find the tagline" do
    @movie.tagline.should =~ /It will blow you through the back wall of the theater/
  end
  
  it "should find the year" do
    @movie.year.should eql(1988)
  end
  
  describe "special scenarios" do
    
    it "should find multiple directors" do
      # The Matrix Revolutions (2003)
      movie = Imdb::Movie.new("0242653")
      
      movie.director.should be_an(Array)
      movie.director.size.should eql(2)
      movie.director.should include("Larry Wachowski")
      movie.director.should include("Andy Wachowski")
    end
  end
  
end