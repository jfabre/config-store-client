
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
 

  def self.add(key_values)
    load_associations
    pairs = Pair.all(params: Pair.prefix_options)
    
    to_create = key_values.select{|k, v| !pairs.any?{|p| p.key == k.to_s } }
    to_update = pairs.select{|p| key_values.keys.any?{|k| p.key == k.to_s } }
    
    to_create.each do |k, v|
      Pair.create(:key => k, :value => v)
    end
    to_update.each { |p| p.save! }
  end

  def self.load_associations
    @org ||= Organization.find(store_keys[:org])
    Store.org = @org
    @store ||= Store.find(store_keys[:store], params: Store.prefix_options)

    Pair.org = @org
    Pair.store = @store
  end

  def self.store_keys
    @keys ||= File.open(".config-store", 'r') { |f| JSON.parse(f.read).inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo } }
  end
end