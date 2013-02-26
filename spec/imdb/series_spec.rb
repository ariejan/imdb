require 'spec_helper'

describe "Imdb::Serie" do
  before(:each) do
    @serie = Imdb::Serie.new("1520211")
  end

  # Double check from Base.
  it "should find title" do
    @serie.title.should =~ /The Walking Dead/
  end

  it "reports the number of seasons" do
    @serie.seasons.size.should eql(3)
  end

  it "can fetch a specific season" do
    @serie.season(1).season_number.should == 1
    @serie.season(1).episodes.size.should == 6
  end
end
