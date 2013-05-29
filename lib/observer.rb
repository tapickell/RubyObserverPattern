module ObserveMe
  attr_reader :observers

  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end
end

class WeatherTracker
  include ObserveMe

  def initialize
    super()
  end

  def current_weather=(conditions)
    @current_weather = conditions
    notify_observers
  end

  def current_weather
    @current_weather
  end

  def call
    current_weather
  end
end

class Toolbar
  attr_reader :status

  def update(context)
    @status = context.call
  end
end