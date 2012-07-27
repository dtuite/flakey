require "spec_helper"

class DummyHelper
  include Flakey::Twitter
end

describe Flakey::Twitter do
  subject { DummyHelper.new }

  describe "twitter_handle" do
    it "should output the twitter handle" do
      subject.twitter_handle.should == 'grinnick'
    end

    it "should take a handle as an argument" do
      subject.twitter_handle('hello').should == 'hello'
    end
  end
end
