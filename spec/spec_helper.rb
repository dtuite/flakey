require "flakey/configuration"
require "flakey/twitter"
require "flakey/facebook"
require "flakey/github"
require "flakey/google_plus"
require "flakey/stackoverflow"

Flakey.configure do |c|
  c.default_twitter_handle = 'grinnick'
end
