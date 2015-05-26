require 'spec_helper'

describe 'Imdb::Season' do
  subject      { Imdb::Serie.new('1520211') }
  let(:season) { subject.seasons.first }

  it 'has 6 episodes' do
    expect(season.episodes.size).to eq(6)
  end

  it 'can fetch a specific episode' do
    episode = season.episode(1)
    expect(episode.title).to match(/Days Gone By/i)
    expect(episode.episode).to eq(1)
    expect(episode.season).to eq(1)
  end
end

describe 'Imdb::Season starting with episode 0' do
  subject        { Imdb::Serie.new('0898266') }
  let(:season)   { subject.season(1) }
  let(:episodes) { season.episodes }

  it 'indexes episode correctly' do
    expect(episodes[0].episode).to eq(0)
    expect(episodes[1].episode).to eq(1)
  end

  it 'returns the correct title' do
    expect(episodes[0].title).to eq('Unaired Pilot')
    expect(episodes[1].title).to eq('Pilot')
  end

  it 'fetches the correct episode' do
    expect(season.episode(0).episode).to eq(0)
    expect(season.episode(1).episode).to eq(1)
  end
end
