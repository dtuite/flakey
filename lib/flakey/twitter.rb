module Flakey
  module Twitter

    def twitter_handle(options = {})
      options[:handle] || Flakey.configuration.default_twitter_handle
    end

    def twitter_url(options = {})
      handle = options[:handle] || twitter_handle
      "https://twitter.com/#{handle}"
    end

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
      class_list = options[:class] || "twitter-share-button"

      data_attr = {
        :via => via,
        :related => related,
        :hashtags => hashtags,
        url: url
      }
      # Twitter will take the page title if we just leave it out.
      data_attr.merge!(text: text) unless text.nil?

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
