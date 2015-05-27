require 'spec_helper'

describe 'Imdb::Serie' do
  subject { Imdb::Serie.new('1520211') }

  # Double check from Base.
  it 'finds the title' do
    expect(subject.title).to match(/The Walking Dead/)
  end

  it 'reports the number of seasons' do
    expect(subject.seasons.size).to eq(5)
  end

  it 'can fetch a specific season' do
    expect(subject.season(1).season_number).to eq(1)
    expect(subject.season(1).episodes.size).to eq(6)
  end
end
