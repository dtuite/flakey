# THis class is used to generate standard Twitter buttons as documented
# on the [Twitter developers site](https://twitter.com/about/resources/buttons).

module Flakey
  module Twitter

    # Get the default Twitter handle for this configuration. If a
    # handle argument is supplied, it will be returned.
    #
    #   twitter_handle
    #   # => The default handle.
    #
    #   twitter_handle('peter')
    #   # => 'peter'
    #
    # Returns a string.
    def twitter_handle(handle = nil)
      handle || Flakey.configuration.default_twitter_handle
    end

    # Get the Twitter profile URL for a handle. If no handle is
    # specified then this method returns the profile URL of the
    # default handle.
    #
    #   twitter_url
    #   # => "https://twitter.com/default
    #
    #   twitter_url('peter')
    #   # => "https://twitter.com/peter"
    #
    # Returns a string.
    def twitter_url(handle = nil)
      handle = handle || twitter_handle
      "https://twitter.com/#{handle}"
    end

    # Generate a tweet button. This method needs the Twitter JavaScript
    # to be loaded on the page to work correctly.
    #
    # Takes a hash of options to use when generating the button.
    #
    # [+url+] The URL to tweet. Default to the current request url.
    # [+text+] The textual body of the Tweet. Defaults to the current
    # page title. This is a Twitter convention.
    # [+hashtags+] A list of hashtags to include in the tweet.
    # [+label+] The text to appear on the tweet button.
    # [+via+] Tweet via an associated abbout. Defaults to the 
    #         +default_tweet_via+ configuration setting.
    # [+related+] A related Twitter handle. Defaults to the
    #             +default_tweet_related+ configuration setting.
    # [+class+] HTML classes to apply to the Tweet button. Defaults
    # to the +default_tweet_button_class+ configuration setting which
    # is <i>"twitter-share-button"</i>.
    # [+size+] 
    #
    # Returns a HTML string.
    def tweet_button(options = {})
      url = options[:url] || request.url
      text = options[:text]
      hashtags = options[:hashtags] ||
        Flakey.configuration.default_tweet_hashtags
      label = options[:label] || 'Tweet'
      via = options[:via] ||
        Flakey.configuration.default_tweet_via
      related = options[:related] ||
        Flakey.configuration.default_tweet_related
      size = options[:size] || 
        Flakey.configuration.default_tweet_button_size
      class_list = options[:class] ||
        Flakey.configuration.default_tweet_button_class

      data_attr = {
        :via => via,
        :related => related,
        :hashtags => hashtags,
        :url => url
      }
      # Twitter will take the page title if we just leave it out.
      data_attr.merge!(text: text) unless text.nil?
      data_attr.merge!(size: size) unless size.nil?

      link_to label, "https://twitter.com/share", 
        :class => class_list, :data => data_attr
    end

    def follow_button(options = {})
      handle = options[:handle] || twitter_handle
      label = options[:label] || "Follow #{handle}"
      size = options[:size] || 'large'
      class_list = options[:class] || "twitter-follow-button"
      show_count = options[:show_count] || "false"

      link_to label, "https://twitter.com/#{handle}", 
        class: class_list, data: { :"show-count" => show_count, size: size }
    end
  end
end
