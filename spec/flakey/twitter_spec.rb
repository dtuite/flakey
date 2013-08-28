# encoding: UTF-8
require "spec_helper"
require 'action_view'

class DummyHelper
  include ::ActionView::Helpers::UrlHelper
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

  describe 'custom_tweet_button' do
    before { subject.stub_chain('request.url') { 'http://example.com/hello' } }
    let(:default_url) { "#{Flakey::Twitter::SHARE_URL}?url=http%3A%2F%2Fexample.com%2Fhello" }

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

    it 'should set a class' do
      subject.custom_tweet_button.should =~ /class="custom-twee/
    end
  end
end
