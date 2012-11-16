module ConfigStore
  class Store < ActiveResource::Base
    extend Query
    self.site = ConfigStore.site
    self.prefix = "/organizations/:org_id/"  

    def self.org= value
      @@org = value
    end

    def prefix_options
      self.class.prefix_options
    end

    def self.prefix_options
      { :org_id => @@org.id }
    end
  end
end