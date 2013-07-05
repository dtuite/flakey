require "spec_helper"

class DummyHelper
  include Flakey::Twitter
end

describe Flakey::Twitter do
  subject { DummyHelper.new }

  describe "#twitter_handle" do
    it "should output the twitter handle" do
      subject.twitter_handle.should == 'grinnick'
    end

    it "should take a handle as an argument" do
      subject.twitter_handle('hello').should == 'hello'
    end
  end

  describe "#tweet_button" do
    before { subject.stub_chain('request.url') { '' } }

    it "should append to the class list" do
      subject.should_receive(:link_to)
        .with("Tweet", Flakey::Twitter::SHARE_URL,
              hash_including(class: 'hello twitter-share-button'))
      subject.tweet_button(class: 'hello')
    end

    it "should work without a class argument" do
      subject.should_receive(:link_to)
        .with("Tweet", Flakey::Twitter::SHARE_URL,
              hash_including(class: 'twitter-share-button'))
      subject.tweet_button
    end
  end

  describe "#follow_button" do
    before { subject.stub_chain('request.url') { '' } }

    it "should append to the class list" do
      subject.should_receive(:link_to)
        .with("Follow @david", subject.twitter_profile_url('david'),
              hash_including(class: 'hello twitter-follow-button'))
      subject.follow_button(handle: 'david', class: 'hello')
    end

    it "should work without a class argument" do
      subject.should_receive(:link_to)
        .with("Follow @david", subject.twitter_profile_url('david'),
              hash_including(class: 'twitter-follow-button'))
      subject.follow_button(handle: 'david')
    end
  end
end
