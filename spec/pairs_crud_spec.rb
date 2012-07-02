require 'spec_helper'
describe Config::Pair do
  Store = Config::Store
  Pair = Config::Pair

  before :all do
    @store = Store.new :name => 'my store'
    @store.save!
    Pair.store = @store
  end
  after :all do
    @store.destroy
  end

  it "creates pairs succesfully" do
    expected = Pair.new :key => 'baba', :value => 'value'
    expected.save!

    actual = Pair.find(expected.id)
    
    actual.should == expected
  end

  it "updates pairs succesfully" do
    pair = Pair.new :key => 'key', :value => 'value'
    pair.save!

    expected = Pair.find(pair.id)
    expected.value = 'update'
    expected.save!

    actual = Pair.find(expected.id)
    
    actual.should == expected
  end  
end