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
      config.twitter_handle = ''

      # Optionally include:
      config.twitter_user_id = nil
      config.tweet_hashtags = ''
      config.tweet_via = ''
      config.tweet_related = ''
      config.tweet_button_count_position = 'horizontal'

      config.follow_button_show_count = 'false'
    end

    # app/assets/javascrippts/application.js
    #= require flakey/twitter

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Flakey::Twitter
    end

    # app/views/layouts/application.html.erb
    <%= tweet_button(hashtags: 'awesome') %>
    <%= link_to "My Twitter Profile", twitter_profile_url %>

### Facebook

    # config/initializers/flakey.rb
    Flakey.configure do |config|
      self.facebook_nickname = ''

      # Optionally include:
      config.facebook_app_id = nil
    end

    # app/assets/javascrippts/application.js
    #= require flakey/facebook

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Flakey::Facebook
    end

    # app/views/layouts/application.html.erb
    <%= like_button(width: 150) %>
    <%= link_to "My Facebook Profile", facebook_profile_url %>

### Github

    # config/initializers/flakey.rb
    Flakey.configure do |config|
      config.github_name = 'dtuite'
    end

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Flakey::Github
    end

    # app/views/layouts/application.html.erb
    <%= link_to "My Github Profile", github_profile_url %>

### Stackoverflow

    # config/initializers/flakey.rb
    Flakey.configure do |config|
      config.stackoverflow_nickname = 'david-tuite'
      config.stackoverflow_user_id = '7389247'
    end

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include Flakey::Stackoverflow
    end

    # app/views/layouts/application.html.erb
    <%= link_to "My Stackoverflow Profile", stackoverflow_profile_url %>

### Google Plus

    # config/initializers/flakey.rb
    Flakey.configure do |config|
      config.google_plus_user_id = "9873465784"

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
    <%= link_to "My Google Plus Profile", google_plus_profile_url %>


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
