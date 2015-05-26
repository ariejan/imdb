require 'spec_helper'

describe Imdb::Top250 do
  subject { Imdb::Top250.new.movies }

  it 'should be a list of movies' do
    subject.each { |movie| expect(movie).to be_an_instance_of(Imdb::Movie) }
  end

  it 'should return the top 250 movies from IMDB.com' do
    expect(subject.size).to eq(250)
  end

  it 'should provide array like access to the movies' do
    expect(subject[0].title).to eq('1. The Shawshank Redemption')
    expect(subject[1].title).to eq('2. The Godfather')
    expect(subject[2].title).to eq('3. The Godfather: Part II')
  end
end
