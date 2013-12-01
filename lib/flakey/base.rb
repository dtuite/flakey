module Flakey
  module Base
    # Allow inclusion in classes that don't respond to :request, or 
    # where request is nil (such as mailers).
    def default_url
      respond_to?(:request) && request.try(:url)
    end
  end
end
