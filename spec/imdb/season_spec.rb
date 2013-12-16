require 'spec_helper'

describe "Imdb::Season" do
  before(:each) do
    @serie = Imdb::Serie.new("1520211")
    @season = @serie.seasons.first
  end

  it "has 6 episodes" do
    @season.episodes.size.should eql(6)
  end

  it "can fetch a specific episode" do
    @season.episode(1).title.should =~ /Days Gone By/i
    @season.episode(1).episode.should == 1
    @season.episode(1).season.should == 1
  end
end

describe "Imdb::Season starting with episode 0" do
  before(:each) do
    @serie = Imdb::Serie.new("0898266")
    @season = @serie.season(1)
    @episodes = @serie.season(1).episodes
  end

  it "should index episode correctly" do
    @episodes[0].episode.should eql(0)
    @episodes[1].episode.should eql(1)
  end

  it "should return the correct title" do
    @episodes[0].title.should eql("Unaired Pilot")
    @episodes[1].title.should eql("Pilot")
  end

  it "should fetch the correct episode" do
    @season.episode(0).episode.should eql(0)
    @season.episode(1).episode.should eql(1)
  end
end
