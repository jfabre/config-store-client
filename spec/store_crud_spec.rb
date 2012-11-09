require 'spec_helper'

describe ConfigStore::Store do
  before :all do    
    @org = ConfigStore::Organization.new(name: 'myorg')
    @org.save!
    ConfigStore::Store.org = @org
  end
  after :all do
    @org.destroy
  end
  
  it "creates one successfully" do
    expected = ConfigStore::Store.new :name => 'abcd', :org_id => @org.id
    expected.save!

    actual = ConfigStore::Store.find(expected.id, params: { :org_id => @org.id })
    actual.should == expected
  end

  it "updates one successfully" do
    store = ConfigStore::Store.new :name => 'abcd'
    store.save!

    expected = ConfigStore::Store.find(store.id, params: { :org_id => @org.id })
    expected.name = 'boombo'
    expected.save!

    actual = ConfigStore::Store.find(expected.id, params: { :org_id => @org.id })
    
    actual.should == expected
  end
end