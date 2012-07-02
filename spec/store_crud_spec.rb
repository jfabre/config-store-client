require 'spec_helper'
describe Config::Store do
  Store = Config::Store
  after :all do
    Store.all.each do |s|
      s.destroy
    end
  end
  
  it "creates one successfully" do
    expected = Store.new :name => 'abcd'
    expected.save!

    actual = Store.find(expected.id)
    actual.should == expected
  end

  it "updates one successfully" do
    store = Store.new :name => 'abcd'
    store.save!

    expected = Store.find(store.id)
    expected.name = 'boombo'
    expected.save!

    actual = Store.find(expected.id)
    
    actual.should == expected
  end
end