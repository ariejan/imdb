# encoding: utf-8

require 'spec_helper'

# This test uses "Bruce Willis" profile page as a testing sample:
#
#     http://akas.imdb.com/name/nm0000246/
#

describe 'Imdb::Person' do

  describe 'valid person' do

    before(:each) do
      # Bruce Willis
      @person = Imdb::Person.new('0000246')
    end

    it 'should find the name' do
      @person.name.should eql("Bruce Willis")
    end

    it 'should find the age' do
      @person.age.should eql(59)
    end

    it 'should find the birthdate' do
      @person.birthdate.should eql("March 19, 1955")
    end

    it 'should find the categories' do
      categories = @person.categories

      categories.should be_an(Array)
      categories.size.should eql(9)
      categories.should include('Actor')
      categories.should include('Soundtrack')
      categories.should include('Producer')
      categories.should include('Writer')
      categories.should include('Music department')
      categories.should include('Miscellaneous Crew')
      categories.should include('Thanks')
      categories.should include('Self')
      categories.should include('Archive footage')
    end
    
    it 'should find all movies as actor' do
      movies = @person.movies_as('actor')

      movies.should be_an(Array)
      movies.size.should eql(101)
      movies.first.id.should eql('2010940')
    end
  end
end
