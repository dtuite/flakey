module Flakey
  module GooglePlus
    BASE_URL = "https://plus.google.com"

    # INFO: https://developers.google.com/+/plugins/+1button/
    def plus_one_button(options = {})
      size = options[:size] || nil
      annotation = options[:annotation] || 'inline'
      width = options[:width] || 300
      class_list = options[:class] || 'g-plusone'
      href = options[:href] || request.url
      callback = options[:callback] || nil

      data_attr = { annotation: annotation, href: href }
      # Width only applies to the 'inline' annotation type.
      data_attr.merge!(width: width) if annotation == 'inline'
      data_attr.merge!(size: size) if size
      data_attr.merge!(callback: callback) if callback

      content_tag :div, '', class: class_list, data: data_attr
    end

    def google_plus_profile_url(user_id = nil)
      user_id = user_id || Flakey.configuration.google_plus_user_id
      BASE_URL + "/#{user_id}"
    end
  end

  def google_plus_profile_url(user_id = nil)
    user_id = user_id || Flakey.configuration.google_plus_user_id
    BASE_URL + "/#{user_id}"
  end
end
