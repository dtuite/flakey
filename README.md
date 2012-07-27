# Flakey

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'flakey'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flakey

## Usage

    # config/initializers/flakey.rb
    Flakey.configure do |config|
      config.twitter do |t|
        t.default_tweet_text = 'Hey check out this awesome gem'
      end
    end

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Flakey::Twitter
    end

    # app/views/layouts/application.html.erb
    <%= tweet_button(hashtags: 'awesome') %>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
