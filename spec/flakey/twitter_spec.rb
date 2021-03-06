# encoding: UTF-8
require "spec_helper"
require 'action_view'

class DummyHelper
  include ::ActionView::Helpers::UrlHelper
  include ::ActionView::Helpers::SanitizeHelper
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
    let(:base) { Flakey::Twitter::SHARE_URL }

    it "should append to the class list" do
      subject.should_receive(:link_to)
        .with("Tweet", base, hash_including(class: 'hello twitter-share-button'))
      subject.tweet_button(class: 'hello')
    end

    it "should work without a class argument" do
      subject.should_receive(:link_to)
        .with("Tweet", base, hash_including(class: 'twitter-share-button'))
      subject.tweet_button
    end

    it "should facilitate an id" do
      subject.should_receive(:link_to)
        .with("Tweet", base, hash_including(id: 'the-id'))
      subject.tweet_button(id: 'the-id')
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

  describe "#tweet_url" do
    before { subject.stub_chain('request.url') { 'http://www.example.com' } }

    it "should include the url" do
      expected = "https://twitter.com/intent/tweet?url=http%3A%2F%2Fwww.example.com"
      subject.tweet_url.should == expected
    end

    it "should include via" do
      subject.tweet_url(:via => "kieran").should =~ /[&?]via=kieran/
    end
    
    it "should include hashtags" do
      subject.tweet_url(:hashtags => "cupoftea").should =~ /[&?]hashtags=cupoftea/
    end
    
    it "should include text" do
      subject.tweet_url(:text => "hello").should =~ /[&?]text=hello/
    end
    
    it "should include related" do
      subject.tweet_url(:related => "someone").should =~ /[&?]related=someone/
    end
  end

  describe 'custom_tweet_button' do
    before { subject.stub_chain('request.url') { 'http://example.com/hello' } }
    let(:default_url) do
      "#{Flakey::Twitter::SHARE_URL}?url=http%3A%2F%2Fexample.com%2Fhello"
    end

    it 'should include the default url and label' do
      subject.should_receive(:link_to)
        .with('Tweet', default_url, hash_including(target: '_blank'))
      subject.custom_tweet_button
    end

    it 'should allow specifying the text' do
      expected_url = "#{default_url}&text=Hello+there"
      subject.should_receive(:link_to)
        .with('Tweet', expected_url, anything)
      subject.custom_tweet_button(text: "Hello there")
    end

    it 'should allow specifying the via' do
      Flakey.configuration.stub(tweet_via: 'hello')
      subject.custom_tweet_button.should =~ /via=hello/
    end

    it 'should not include blank via' do
      Flakey.configuration.stub(tweet_via: '')
      subject.custom_tweet_button.should_not =~ /&via=/
    end

    it 'should not have via in the hyml' do
      Flakey.configuration.stub(tweet_via: '')
      subject.custom_tweet_button.should_not =~ /via=""/
    end

    it 'should set a class' do
      subject.custom_tweet_button.should =~ /class="custom-twee/
    end
  end
end
