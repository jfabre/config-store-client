module ConfigStore
  class Organization < ActiveResource::Base
    self.site = "http://127.0.0.1:3000"

    def stores
      []
    end
  end
end