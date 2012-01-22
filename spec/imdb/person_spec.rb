require 'spec_helper'

# This test uses "Die hard (1988)" as a testing sample:
#
#     http://akas.imdb.com/title/tt0095016/combined
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

  end

end
