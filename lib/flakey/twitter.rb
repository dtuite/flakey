module Flakey
  module Twitter

    def twitter_handle(handle = nil)
      handle or Flakey.configuration.default_twitter_handle
    end

    def twitter_url(options = {})
      handle = options[:handle] or twitter_handle
      "https://twitter.com/#{handle}"
    end

    def tweet_button(options = {})
      url = options[:url] || request.url
      # TODO: THe text should default to the page title. I think
      # it will do this by itself if I just leave it out
      # of the data attributes hash?
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
