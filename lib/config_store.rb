module ConfigStore
  VERSION = '0.1'
  def self.site
    @site || 'http://127.0.0.1:3000'
  end
  def self.site=(value)
    @site = value
  end
  def self.store_keys
    @keys ||= get_store_keys 
  end
  def self.get_store_keys
    if File.exists? '.config-store'
      File.open('.config-store', 'r') { |f| JSON.parse(f.read).inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo } }
    else
      {} 
    end
  end
  
  self.site = store_keys[:site] 
  dir = File.dirname(__FILE__) 
  autoload :Query, "#{dir}/config_store/query"
  autoload :Pair, "#{dir}/config_store/pair"
  autoload :Organization, "#{dir}/config_store/organization"
  autoload :Store, "#{dir}/config_store/store"

  def self.setup(org_name, store_name, site)
    unless site.nil?
      Organization.site = site
      Store.site = site
      Pair.site = site
    end
    org = Organization.find_by_name(org_name) || Organization.create(name: org_name)
    Store.org = org
    store = Store.find_by_name(store_name) || Store.create(name: org_name)

    to_store = {:store => store.id, :org => org.id, :site => site || store_keys[:site]}.to_json
    File.open(".config-store", 'w') {|f| f.write(to_store) }
  end
  
  def self.show
    load_associations
    pairs = index

    if pairs.size > 0
      params = pairs.inject("") do |sum, p|
        sum << "#{p.key}=#{p.value}\n"
      end
    else
      params = "No key in the store right now"
    end
    puts "\nConfiguration for org:#{organization.name} store:#{store.name}\n--------------\n" << params
  end
  
  def self.export
    load_associations
    pairs = index

    if pairs.size > 0
      command = pairs.map{|p| "export #{p.key}=#{p.value}" }.join(' && ')
      $stdout.write command
    else
      $stdout.write "echo \"config-store: Nothing to export.\""
    end
  end

  def self.add(key_values)
    load_associations
    pairs = index
    
    to_create = key_values.select{|k, v| !pairs.any?{|p| p.key == k.to_s } }
    to_update = pairs.select{|p| key_values.keys.any?{|k| p.key == k.to_s } }

    to_create.each do |k, v|
      Pair.create(:key => k, :value => v)
    end
    to_update.each { |p| p.save! }
  end

  def self.delete(keys)
    load_associations

    if keys.size > 0
      to_remove = index.select{|p| keys.any?{|k| p.key == k } }
      
      to_remove.each{|p| p.destroy }
    end
  end

  private 
    def self.index
      @pairs ||= Pair.all(params: Pair.prefix_options)
    end

    def self.load_associations
      Store.org = organization
      Pair.org = organization
      Pair.store = store
    end
    
    def self.store
      @store ||= Store.find(store_keys[:store], params: Store.prefix_options)
    end
    def self.organization
      @org ||= Organization.find(store_keys[:org])
    end
    def self.store_keys
      @keys ||= File.open(".config-store", 'r') { |f| JSON.parse(f.read).inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo } }
    end
end
