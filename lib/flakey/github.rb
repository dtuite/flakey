module Flakey
  module Github
    def github_name(options = {})
      options[:name] || Flakey.configuration.github_name
    end

    def github_profile_url(options = {})
      name = options[:name] || github_name
      "https://github.com/" + name
    end
  end
end
