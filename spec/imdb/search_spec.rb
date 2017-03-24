require 'spec_helper'

describe 'Imdb::Search with multiple search results' do
  context 'Star Trek: TOS' do
    subject { Imdb::Search.new('Star Trek: TOS') }

    it 'remembers the query' do
      expect(subject.query).to eq('Star Trek: TOS')
    end

    it 'finds 14 results' do
      expect(subject.movies.size).to eq(14)
    end

    it 'returns Imdb::Movie objects only' do
      subject.movies.each { |movie| expect(movie).to be_a(Imdb::Movie) }
    end

    it 'does not return movies with no title' do
      subject.movies.each { |movie| expect(movie.title).to_not be_blank }
    end

    it 'returns only the title of the result' do
      expect(subject.movies.first.title).to eq('Star Trek (1966) (TV Series)')
    end
  end
end

describe 'Imdb::Search with an exact match and no poster' do
  it 'does not raise an exception' do
    expect do
      subject = Imdb::Search.new('Kannethirey Thondrinal').movies
    end.not_to raise_error
  end

  context 'Kannethirey Thondrinal' do
    subject { Imdb::Search.new('Kannethirey Thondrinal') }

    it 'returns the movie id correctly' do
      expect(subject.movies.first.id).to eq('0330508')
    end
  end
end

describe 'Imdb::Search with a type filter' do
  context 'TV shows' do
    subject { Imdb::Search.new('Star Trek: TOS', :tv) }

    it 'finds 10 results' do
      expect(subject.movies.size).to eq(10)
    end
  end

  context 'unsupported type' do
    subject { Imdb::Search.new('Star Trek: TOS', :unsupported) }

    it 'finds the regular results' do
      expect(subject.movies.size).to eq(14)
    end
  end
end
