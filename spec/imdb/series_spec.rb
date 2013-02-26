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
end
