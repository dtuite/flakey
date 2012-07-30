module Flakey
  module Stackoverflow
    def stackoverflow_nickname(options = {})
      options[:nickname] || Flakey.configuration.stackoverflow_nickname
    end

    def stackoverflow_profile_url(options = {})
      user_id = Flakey.configuration.stackoverflow_user_id
      "http://stackoverflow.com/users/#{user_id}/#{stackoverflow_nickname}"
    end
  end
end
