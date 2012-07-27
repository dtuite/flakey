# Enable setting and getting of configuration options.
#
# Example:
#
#   This can now be used under config/initializers/flakey.rb
#   Flakey.configure do |config|

#   end

module Flakey
  class Configuration
    DEFAULT_TWITTER_HANDLE = ''
    DEFAULT_TWEET_HASHTAGS = ''
    DEFAULT_TWEET_VIA = ''
    DEFAULT_TWEET_RELATED = ''

    DEFAULT_FACEBOOK_NICKNAME = ''

    attr_accessor :default_twitter_handle, :default_tweet_hashtags,
      :default_tweet_via, :default_tweet_related,
      :default_facebook_nickname, :facebook_app_id,
      :default_stackoverflow_nickname, :default_stackoverflow_user_id,
      :default_github_name

    def initialize
      self.default_twitter_handle = DEFAULT_TWITTER_HANDLE
      self.default_tweet_hashtags = DEFAULT_TWEET_HASHTAGS
      self.default_tweet_via = DEFAULT_TWEET_VIA
      self.default_tweet_related = DEFAULT_TWEET_RELATED

      self.default_facebook_nickname = DEFAULT_FACEBOOK_NICKNAME
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
