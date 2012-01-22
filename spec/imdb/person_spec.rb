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

    it "should get a list of the person's roles"

  end

end
