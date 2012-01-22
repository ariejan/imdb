require 'spec_helper'

# This test uses "Nicole Kidman" as a testing sample:
#
#     http://akas.imdb.com/name/nm0000173
#

describe "Imdb::Person" do

  describe "valid person" do

    before(:each) do
      # Get Nicole Kidman
      @person = Imdb::Person.new("0000173")
    end

    it "should get the person's name" do
      name = @person.name

      name.should be_a(String)
      name.should include("Nicole Kidman")
    end

    it "should get the person's date of birth" do
      dob = @person.birth_date

      dob.should be_a(String)
      dob.should include("1967-06-20")
    end

    it "should get a list of the person's roles" do
      roles = @person.roles

      roles.should be_an(Array)
      roles.should include("Actress")
      roles.should include("Producer")
      roles.should include("Soundtrack")
    end

    it "should get a list of all the types of items that person is accredited to" do
      filmography_types = @person.filmography_types

      filmography_types.should be_an(Array)
      filmography_types.should include("Actress")
      filmography_types.should include("Producer")
      filmography_types.should include("Soundtrack")
      filmography_types.should include("Music Department")
      filmography_types.should include("Thanks")
      filmography_types.should include("Self")
      filmography_types.should include("Archive Footage")
    end

    describe "filmography" do

      it "should return all items that person is accredited to by default" do
        films = @person.filmography

        films.should be_an(Array)
        films.each { |f| f.should be_an(Imdb::Movie) }
        films[0].title.should include("Love and Pain and the Whole Damn Thing")
        films[20].title.should include("Happy Feet")
        films[40].title.should include("To Die For")
        films[60].title.should include("Archer")
      end

      it "should allow for the items to be filtered by role" do
        films = @person.filmography("Actress")

        films.should be_an(Array)
        films.each { |f| f.should be_an(Imdb::Movie) }
        films[4].title.should include("Rabbit Hole")
        films[10].title.should include("Happy Feet")
        films[12].title.should include("Bewitched")
        films[48].title.should include("Room to Move")
      end

      it "should handle being passed a role that person has no credits for" do
        films = @person.filmography("Badger")

        films.should be_an(Array)
        films.count.should be(0)
      end

    end

  end

end
