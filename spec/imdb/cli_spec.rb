require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'imdb/cli'

describe Imdb::CLI, "execute" do
  
  describe "yield search results" do
    before(:each) do
      @stdout_io = StringIO.new
      Imdb::CLI.execute(@stdout_io, ["Star Trek"])
      @stdout_io.rewind
      @stdout = @stdout_io.read
    end
  
    it "report data" do
      @stdout.should =~ /0060028/
      @stdout.should =~ /Star Trek/
      @stdout.should =~ /1966/
    end
  end

  describe "yield one movie an ID" do
    before(:each) do
      @stdout_io = StringIO.new
      Imdb::CLI.execute(@stdout_io, ["0117731"])
      @stdout_io.rewind
      @stdout = @stdout_io.read
    end
  
    it "report data" do
      @stdout.should =~ /Star Trek\: First Contact \(1996\)/
      @stdout.should =~ /Jonathan Frakes/
    end
  end
  
  describe "yield one movie with an URL" do
    before(:each) do
      @stdout_io = StringIO.new
      Imdb::CLI.execute(@stdout_io, ["http://www.imdb.com/title/tt0117731/"])
      @stdout_io.rewind
      @stdout = @stdout_io.read
    end
  
    it "report data" do
      @stdout.should =~ /Star Trek\: First Contact \(1996\)/
      @stdout.should =~ /Jonathan Frakes/
    end
    
  end
end
