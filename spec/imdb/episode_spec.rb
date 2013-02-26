require 'spec_helper'

describe "Imdb::Episode" do
  before(:each) do
    @serie = Imdb::Serie.new("1520211")
    @season = @serie.seasons.first
    @episode = @season.episode(1)
  end

  it "has an episode title" do
    @episode.title.should =~ /Days Gone By/i
  end

  it "has the season number" do
    @season.episode(1).season.should == 1
  end

  it "has the episode number" do
    @season.episode(1).episode.should == 1
  end
end


