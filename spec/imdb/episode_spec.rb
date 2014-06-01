require 'spec_helper'

describe 'Imdb::Episode' do
  before(:each) do
    @serie = Imdb::Serie.new('1520211')
    @season = @serie.seasons.first
    @episode = @season.episode(2)
  end

  it 'has a imdb_id' do
    @episode.id.should == '1628064'
  end

  it 'has a url' do
    @episode.url.should == 'http://akas.imdb.com/title/tt1628064/combined'
  end

  it 'has an episode title' do
    @episode.title.should =~ /Guts/i
  end

  it 'has the season number' do
    @episode.season.should == 1
  end

  it 'has the episode number' do
    @episode.episode.should == 2
  end

  it 'has a plot' do
    @episode.plot.should =~ /Rick finds himself trapped with other survivors inside a department store, surrounded by walkers/
  end

  it 'has a original air data' do
    @episode.air_date.should eql('7 November 2010')
  end
end
