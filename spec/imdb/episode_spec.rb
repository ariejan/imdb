require 'spec_helper'

describe 'Imdb::Episode' do
  let(:serie)   { Imdb::Serie.new('1520211') }
  let(:season)  { serie.seasons.first }
  let(:episode) { season.episode(2) }

  it 'has a imdb_id' do
    expect(episode.id).to eq('1628064')
  end

  it 'has a url' do
    expect(episode.url).to eq('http://akas.imdb.com/title/tt1628064/combined')
  end

  it 'has an episode title' do
    expect(episode.title).to match(/Guts/i)
  end

  it 'has the season number' do
    expect(episode.season).to eq(1)
  end

  it 'has the episode number' do
    expect(episode.episode).to eq(2)
  end

  it 'has a plot' do
    expect(episode.plot).to match(/Rick finds himself trapped with a group of survivors inside a department store that is surrounded by walkers./)
  end

  it 'has a original air data' do
    expect(episode.air_date).to eq('7 November 2010')
  end
end
