module ConfigStore
  class Pair < ActiveResource::Base
    extend Query
    self.site = "http://127.0.0.1:3000"
    self.prefix = "/organizations/:org_id/stores/:store_id/"  
    
    def self.store= value
      @@store = value
    end
    def self.org= value
      @@org = value
    end

    def prefix_options
      self.class.prefix_options
    end

    def self.prefix_options
      { :org_id => @@org.id, :store_id => @@store.id }
    end

  end
end