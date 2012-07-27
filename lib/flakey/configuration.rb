# Enable setting and getting of configuration options.
#
# Example:
#
#   This can now be used under config/initializers/flakey.rb
#   Flakey.configure do |config|

#   end

module Flakey
  class Configuration
    attr_accessor :default_twitter_handle, :default_tweet_hashtags,
      :default_tweet_via, :default_tweet_related,
      :default_facebook_nickname, :facebook_app_id,
      :default_stackoverflow_nickname, :default_stackoverflow_user_id,
      :default_github_name, :plus_one_button_language

    def initialize
      self.default_twitter_handle = ''
      self.default_tweet_hashtags = ''
      self.default_tweet_via = ''
      self.default_tweet_related = ''

      self.default_facebook_nickname = ''

    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
