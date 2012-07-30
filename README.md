# Flakey [![Build Status](https://secure.travis-ci.org/dtuite/flakey.png?branch=master)](http://travis-ci.org/dtuite/flakey)

Social button helpers for your Rails 3.1 projects.

## Installation

Add this line to your application's Gemfile:

    gem 'flakey'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flakey

## Usage

### Twitter

    # config/initializers/flakey.rb
    Flakey.configure do |config|
      # Optionally include:
      # config.default_twitter_handle = 'dtuite'
      # config.default_tweet_hastags = ''
      # config.default_tweet_via = ''
      # config.default_tweet_related = ''
    end

    # app/assets/javascrippts/application.js
    #= require flakey/twitter

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Flakey::Twitter
    end

    # app/views/layouts/application.html.erb
    <%= tweet_button(hashtags: 'awesome') %>

### Facebook

    # config/initializers/flakey.rb
    Flakey.configure do |config|
      config.facebook_app_id = '<YOUR_APP_ID>'
      config.default_facebook_nickname = '<A_FACEBOOK_NICKNAME>'
    end

    # app/assets/javascrippts/application.js
    #= require flakey/facebook

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Flakey::Facebook
    end

    # app/views/layouts/application.html.erb
    <%= like_button(width: 150) %>

### Github

    # config/initializers/flakey.rb
    Flakey.configure do |config|
      config.default_github_name = 'dtuite'
    end

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Flakey::Github
    end

    # app/views/layouts/application.html.erb
    <%= link_to "Github", github_url %>

### Stackoverflow

    # config/initializers/flakey.rb
    Flakey.configure do |config|
      config.default_stackoverflow_nickname = 'david-tuite'
      config.default_stackoverflow_user_id = '7389247'
    end

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Flakey::Stackoverflow
    end

    # app/views/layouts/application.html.erb
    <%= link_to "Stackoverflow Profile", stackoverflow_profile_url %>

### Google Plus

    # config/initializers/flakey.rb
    Flakey.configure do |config|
      # Optionally:
      # Should be of the form of, for example, 'en-GB' or 'de'.
      # config.plus_one_button_language = 'en-GB'
    end

    # app/assets/javascrippts/application.js
    #= require flakey/google_plus

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Flakey::GooglePlus
    end

    # app/views/layouts/application.html.erb
    <%= plus_one_button %>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
