require "observer.rb"

describe ObserveMe do
  class MockClass
    include ObserveMe
    def initialize
      super()
    end
  end

  before(:all) do
    @mock = MockClass.new
  end

  describe "newly initialized observable class" do
    it "should initialize with an empty observers array" do
      @mock.observers.should == []
    end
  end

  describe "add_observer" do
    it "should add an observer to the observer array" do
      @mock.add_observer(:observer1)
      @mock.observers.should == [:observer1]
    end
  end

  describe "remove_observer" do
    it "should remove the passed in observer from the array" do
      @mock.remove_observer(:observer1)
      @mock.observers.should == []
    end
  end
end

describe WeatherTracker do
  before(:each) do
    @weather = WeatherTracker.new
  end

  describe "current_weather=" do
    it "should set the current weather to the symbol passed in" do
      @weather.current_weather = :sunny
      @weather.current_weather.should == :sunny
    end

    it "should notify observers of weather change" do
      @weather.should_receive(:notify_observers)
      @weather.current_weather = :rainy
    end
  end

  describe "newly initialized observable class" do
    it "should initialize with an empty observers array" do
      @weather.observers.should == [] 
    end
  end

  describe "add_observer" do
    it "should add an observer to the observer array" do
      @weather.add_observer(:observer1)
      @weather.observers.should == [:observer1]
    end
  end

  describe "remove_observer" do
    it "should remove the passed in observer from the array" do
      @weather.add_observer(:observer1)
      @weather.remove_observer(:observer1)
      @weather.observers.should == []
    end
  end 

end

describe Toolbar do
  before(:each) do
    @weather = double("weather")
    @toolbar = Toolbar.new
  end

  describe "update" do
    it "should set status to symbol returned from passed in object" do
      @weather.stub(:call).and_return(:windy)
      @toolbar.update(@weather)
      @toolbar.status.should == :windy
    end
  end

end


describe "Integration Test" do
  before(:all) do
    @weather = WeatherTracker.new
    @toolbar = Toolbar.new
    @weather.add_observer(@toolbar)
  end

  it "should update the toolbars status when weathers conditions are changed" do
    @weather.current_weather = :stormy
    @toolbar.status.should == :stormy
  end
end