require 'bundler/setup'
require 'active_resource'

module ConfigStore
  VERSION = '0.1'
  class Store < ActiveResource::Base
    self.site  = "http://127.0.0.1:3000/organizations/1"
  end
  class Pair < ActiveResource::Base
    self.site  = "http://127.0.0.1:3000/organizations/1"

    def self.store=(store)
      self.site = "http://127.0.0.1:3000/organizations/1/stores/#{store.id}" 
    end
  end
end