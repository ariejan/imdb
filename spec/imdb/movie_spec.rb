require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

# This test uses "Die hard (1988)" as a testing sample:
#   
#     http://www.imdb.com/title/tt0095016/
#

describe "Imdb::Movie" do
  
  describe "valid movie" do

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

    describe 'fetching a list of imdb actor ids for the cast members' do
      it 'should not require arguments' do
        lambda { @movie.cast_member_ids }.should_not raise_error(ArgumentError)
      end
      
      it 'should not allow arguments' do
        lambda { @movie.cast_member_ids(:foo) }.should raise_error(ArgumentError)
      end

      it 'should return the imdb actor number for each cast member' do
        @movie.cast_member_ids.sort.should == [
          "nm0000246", "nm0000614", "nm0000889", "nm0000952", "nm0001817", "nm0040472", "nm0127960", "nm0236525", "nm0319739", "nm0322339", "nm0324231", "nm0687270", "nm0793363", "nm0924636", "nm0936591"
        ].sort
      end
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
      genres.should include('Thriller')
    end

    it "should find the languages" do
      languages = @movie.languages

      languages.should be_an(Array)
      languages.size.should eql(3)
      languages.should include('English')
      languages.should include('German')
      languages.should include('Italian')
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
      #TODO: in live they are rotating so we should check for more
      @movie.tagline.should =~ /40 Stories Of Sheer Adventure!/
      #@movie.tagline.should =~ /It will blow you through the back wall of the theater/
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
        movie.director.should include("Lana Wachowski")
        movie.director.should include("Andy Wachowski")
      end
    end

    it "should provide a convenience method to search" do
      movies = Imdb::Movie.search("Star Trek")
      movies.should respond_to(:each)
      movies.each { |movie| movie.should be_an_instance_of(Imdb::Movie) }
    end
  
    it "should provide a convenience method to top 250" do
      movies = Imdb::Movie.top_250
      movies.should respond_to(:each)
      movies.each { |movie| movie.should be_an_instance_of(Imdb::Movie) }
    end
  end
  
  describe "plot" do
    it "should find a correct plot when HTML links are present" do
      movie = Imdb::Movie.new("0083987")
      movie.plot.should eql("Biography of Mahatma Gandhi, the lawyer who became the famed leader of the Indian revolts against the British through his philosophy of non-violent protest.")
    end
    
    it "should not have a 'more' link in the plot" do
      movie = Imdb::Movie.new("1352369")
      movie.plot.should eql("An unnamed doctor has always had everything he's ever wanted, but that has only made him develop more extreme and depraved needs...")      
    end
  end
  
  describe "mpaa rating" do
    it "should find the mpaa rating when present" do
      movie = Imdb::Movie.new("0111161")
      movie.mpaa_rating.should == "Rated R for language and prison violence (certificate 33087)"
    end
    
    it "should be nil when not present" do
      movie = Imdb::Movie.new("0095016")
      movie.mpaa_rating.should be_nil
    end
  end
  
  describe "with no submitted poster" do
    
    before(:each) do 
      # Grotesque (2009)
      @movie = Imdb::Movie.new("0330508")
    end
    
    it "should have a title" do
      @movie.title(true).should =~ /Kannethirey Thondrinal/
    end
    
    it "should have a year" do 
      @movie.year.should eql(1998)
    end
    
    it "should return nil as poster url" do
      @movie.poster.should be_nil
    end

    it "should return the release date for movies" do
      movie = Imdb::Movie.new('0111161')
      movie.release_date.should eql("3 March 1995 (Sweden)")
    end
  end

  describe "with an old poster (no @@)" do
    before(:each) do
      # Pulp Fiction (1994)
      @movie = Imdb::Movie.new("0110912")
    end

    it "should have a poster" do
      @movie.poster.should eql("http://ia.media-imdb.com/images/M/MV5BMjE0ODk2NjczOV5BMl5BanBnXkFtZTYwNDQ0NDg4.jpg")
    end
  end
end
