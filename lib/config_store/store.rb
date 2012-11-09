module ConfigStore
  class Store < ActiveResource::Base
    self.site = "http://127.0.0.1:3000"
    self.prefix = "/organizations/:org_id/"  

    def self.org= value
      @@org = value
    end

    def prefix_options
      { :org_id => @@org.id }
    end
  end
end