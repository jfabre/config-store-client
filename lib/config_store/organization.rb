module ConfigStore
  
  class Organization < ActiveResource::Base
    extend Query
    self.site = ConfigStore.site
    def self.prefix_options
      {}
    end
  end
end