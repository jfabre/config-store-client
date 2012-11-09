module ConfigStore
  
  class Organization < ActiveResource::Base
    extend Query
    self.site = "http://127.0.0.1:3000"
    def self.prefix_options
      {}
    end
  end
end