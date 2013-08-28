module Flakey
  module Facebook
    SHARE_URL = 'https://www.facebook.com/sharer/sharer.php'

    def facebook_nickname(options = {})
      options[:nickname] ||
        Flakey.configuration.facebook_nickname
    end

    def facebook_profile_url(options = {}) 
      nickname = options[:nickname] || facebook_nickname
      "https://www.facebook.com/" + nickname
    end

    # Generate a traditional tweet button. This method needs the Facebook
    # JavaScript to be loaded on the page to work correctly.
    #
    # Takes a hash of options used to generate the button.
    #
    # [+url+] The URL to like. Default to the current request url.
    # [+layout+] String. The layout of the button.
    # [+width+] Integer. The width of the area taken up by the button.
    # [+send+] Boolean. Include a Send button or not.
    # [+font+] String. The font to use for the button text.
    # [+class_list+] String. Must include 'fb-like' if overwriting.
    # [+show_faces+] Boolean. Whether to show faces or not.
    #
    # Returns a HTML string.
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

    # Generate a Facebook Share button.
    # INFO: http://goo.gl/MvqIi4
    #
    # Returns a HTML string.
    def share_button(options = {})
      label = options[:label] || 'Share'
      url = options[:url] || request.url

      link_to label, "#{SHARE_URL}?u=#{url}", target: '_blank'
    end
  end
end
