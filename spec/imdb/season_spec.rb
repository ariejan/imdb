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

