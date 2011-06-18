require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Imdb::Config" do
  
  describe "accept_language" do

    it "should set/get the accept_language" do
      Imdb::Config.accept_language="hu"
      Imdb::Config.accept_language == "hu"
    end
  end
end