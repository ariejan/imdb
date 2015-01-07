require 'spec_helper'

describe Imdb::BoxOffice do
  before(:each) do
    @movies = Imdb::BoxOffice.new.movies
  end

  it 'should be a list of movies' do
    @movies.each { |movie| movie.should be_an_instance_of(Imdb::Movie) }
  end

  it 'should return the box office movies from IMDB.com' do
    @movies.size.should eq(10)
  end

  it 'should provide array like access to the movies' do
    @movies[0].title.should eq('Big Hero 6')
    @movies[1].title.should eq('Interstellar')
    @movies[2].title.should eq('Gone Girl')
  end
end
