module Flakey
  module Buffer
    include Base

    SHARE_URL = "https://bufferapp.com/add"

    def buffer_button(options = {})
      defaults = {
        url: default_url,
        label: "Buffer",
        target: '_blank',
        class: 'buffer-add-button'
      }
      settings = defaults.merge(options)

      url = "#{SHARE_URL}?url=#{CGI.escape(settings[:url])}"

      if settings.has_key?(:text) && settings[:text] != ''
        url += "&text=#{CGI.escape(settings[:text])}"
      end

      # Delete these so we can pass the settings directly into link_to
      %w[url text].each { |url_key| settings.delete(url_key.to_sym) }

      if block_given?
        link_to(url, settings, &block)
      else
        link_to settings.delete(:label), url, settings
      end
    end
  end
end
