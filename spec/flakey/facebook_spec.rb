# encoding: UTF-8
require "spec_helper"
require 'action_view'

class DummyHelper
  include ::ActionView::Helpers::UrlHelper
  include Flakey::Facebook
end

describe Flakey::Facebook do
  subject { DummyHelper.new }

  describe 'share_button' do
    before { subject.stub_chain('request.url') { 'http://example.com/hello' } }
    let(:default_url) do
      "#{Flakey::Facebook::SHARE_URL}?u=http%3A%2F%2Fexample.com%2Fhello"
    end

    it 'should add the url' do
      subject.share_button.should include(default_url)
    end

    it 'should have a class' do
      subject.share_button.should include('class="facebook-share-but')
    end

    it 'should render a label' do
      subject.share_button(label: 'Grinnick').should include('>Grinnick</a>')
    end
  end
end
