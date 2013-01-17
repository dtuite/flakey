module Flakey
  module Facebook
    def facebook_nickname(options = {})
      options[:nickname] ||
        Flakey.configuration.facebook_nickname
    end

    def facebook_profile_url(options = {}) 
      nickname = options[:nickname] || facebook_nickname
      "https://www.facebook.com/" + nickname
    end

    def like_button(options = {})
      url = options[:url] || request.url
      layout = options[:layout] || 'button_count'
      width = options[:width] || 250
      send = options[:send] || false
      font = options[:font] || 'tahoma'
      class_list = options[:class] || 'fb-like'
      show_faces = options[:show_faces] || false

      content_tag :div, '', :class => class_list, data: {
        href: url, send: send, layout: layout, width: width.to_s,
        :'show-faces' => show_faces, font: font
      }
    end
  end
end
