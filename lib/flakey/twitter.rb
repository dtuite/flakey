# THis class is used to generate standard Twitter buttons as documented
# on the [Twitter developers site](https://twitter.com/about/resources/buttons).

module Flakey
  module Twitter
    BASE_URL = "https://twitter.com"
    SHARE_URL = BASE_URL + "/share"

    # Default HTML classes for the various buttons.
    TWEET_BUTTON_CLASS = 'twitter-share-button'
    FOLLOW_BUTTON_CLASS = 'twitter-follow-button'

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
      handle || Flakey.configuration.twitter_handle
    end

    # Get the Twitter profile URL for a handle. If no handle is
    # specified then this method returns the profile URL of the
    # default handle.
    #
    #   twitter_profile_url
    #   # => "https://twitter.com/default
    #
    #   twitter_profile_url('peter')
    #   # => "https://twitter.com/peter"
    #
    # Returns a string.
    def twitter_profile_url(handle = nil)
      handle = handle || twitter_handle
      BASE_URL + "/#{handle}"
    end

    # Generate a tweet button. This method needs the Twitter JavaScript
    # to be loaded on the page to work correctly.
    #
    # Takes a hash of options to use when generating the button.
    #
    # [+url+] The URL to tweet. Default to the current request url.
    # [+text+] The textual body of the Tweet. Defaults to the current page title. This is a Twitter convention.
    # [+hashtags+] A list of hashtags to include in the tweet. Can be globally configured by setting +tweet_hashtags+.
    # [+label+] The text to appear on the tweet button. Can be configured by setting +tweet_label+.
    # [+via+] Tweet via an associated about. Defaults to the +tweet_via+ configuration setting.
    # [+related+] A related Twitter handle. Defaults to the +tweet_related+ configuration setting.
    # [+class+] HTML classes to apply to the Tweet button. Defaults to the +tweet_button_class+ configuration setting which is <i>"twitter-share-button"</i>.
    # [+size+] The size of the button. Valid options are <i>nil</i> (default) and </i>'large'</i>.
    #
    # Returns a HTML string.
    def tweet_button(options = {})
      url = options[:url] || request.url
      text = options[:text]
      hashtags = options[:hashtags] ||
        Flakey.configuration.tweet_hashtags
      label = options[:label] ||
        Flakey.configuration.tweet_label
      via = options[:via] ||
        Flakey.configuration.tweet_via
      related = options[:related] ||
        Flakey.configuration.tweet_related
      size = options[:size] || 
        Flakey.configuration.tweet_button_size
      class_list = options[:class] ||
        Flakey.configuration.tweet_button_class

      data_attr = {
        :via => via,
        :related => related,
        :hashtags => hashtags,
        :url => url
      }
      # Twitter will take the page title if we just leave it out.
      data_attr.merge!(text: text) unless text.nil?
      data_attr.merge!(size: size) unless size.nil?
      class_list = class_list ? 
        class_list.concat(' ' + TWEET_BUTTON_CLASS) : TWEET_BUTTON_CLASS

      link_to label, SHARE_URL, :class => class_list, :data => data_attr
    end

    # Generate a follow button. This method needs the Twitter JavaScript
    # to be loaded on the page in order to work correctly.
    #
    # Takes a hash of options to use when generating the button.
    #
    # [+handle+] The Twitter handle of the user to follow. Defaults to the +twitter_handle+ configuration.
    # [+size+] The button size. Can be +nil+ or +'large'+. Configure globally with +follow_button_size+.
    # [+class_list+] HTML classes to apply to the button. Configure globally with +follow_button_class+.
    # [+show_count+] Show the follow count. Defaults to false. Configure globally with +follow_button_show_count+.
    #
    # Returns a HTML string.
    def follow_button(options = {})
      handle = options[:handle] || twitter_handle
      label = options[:label] || "Follow @#{handle}"
      size = options[:size] ||
        Flakey.configuration.follow_button_size
      class_list = options[:class] ||
        Flakey.configuration.follow_button_class
      show_count = options[:show_count] ||
        Flakey.configuration.follow_button_show_count

      class_list = class_list ? 
        class_list.concat(' ' + FOLLOW_BUTTON_CLASS) : FOLLOW_BUTTON_CLASS

      link_to label, twitter_profile_url(handle),
        class: class_list, data: { :"show-count" => show_count, size: size }
    end
  end
end
