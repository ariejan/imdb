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
    @serie.number_of_seasons.should eql(3)
  end

  it "reports seaons urls" do
    @serie.season_urls.should include(
      "http://akas.imdb.com/title/tt1520211/episodes#season-1",
      "http://akas.imdb.com/title/tt1520211/episodes#season-2",
      "http://akas.imdb.com/title/tt1520211/episodes#season-3"
    )
  end
end
