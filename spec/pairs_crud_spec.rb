require 'spec_helper'

describe ConfigStore::Pair do
  before :all do
    @org = ConfigStore::Organization.new name: 'org'
    @org.save!
    ConfigStore::Store.org = @org

    @store = ConfigStore::Store.new :name => 'my store'
    @store.save!

    ConfigStore::Pair.store = @store
    ConfigStore::Pair.org = @org
  end

  after :all do
    @org.destroy
  end

  it "creates pairs succesfully" do
    expected = ConfigStore::Pair.new key: 'baba', value: 'value'
    expected.save!

    actual = ConfigStore::Pair.find(expected.id, :params => { store_id: @store.id, org_id: @org.id })
    
    actual.should == expected
  end

  it "updates pairs succesfully" do
    pair = ConfigStore::Pair.new key: 'key', value: 'value'
    pair.save!

    expected = ConfigStore::Pair.find(pair.id, params: {store_id: @store.id, org_id: @org.id })
    expected.value = 'update'
    expected.save!

    actual = ConfigStore::Pair.find(expected.id, params: {store_id: @store.id, org_id: @org.id })
    
    actual.should == expected
  end  
end