
module ConfigStore
  VERSION = '0.1'

  dir = File.dirname(__FILE__) 
  autoload :Query, "#{dir}/config_store/query"
  autoload :Pair, "#{dir}/config_store/pair"
  autoload :Organization, "#{dir}/config_store/organization"
  autoload :Store, "#{dir}/config_store/store"

  def self.setup(org_name, store_name)
    org = Organization.find_by_name(org_name) || Organization.create(name: org_name)
    Store.org = org

    store = Store.find_by_name(store_name) || Store.create(name: org_name)

    to_store = {:store => store.id, :org => org.id}.to_json
    File.open(".config-store", 'w') {|f| f.write(to_store) }
  end
end