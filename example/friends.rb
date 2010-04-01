require File.dirname(__FILE__) + '/../lib/friend'

class Car
  attr_reader :engine
  def initialize; @engine = Engine.new end
  
  def turn_on(key)
    if key == "foo"
      @engine.engage
      puts "Car turned on!"
    else
      puts "Wrong key!"
    end
  end
end

class Engine
  private
  def engage; puts "Engine turned on!" end
  friend :engage, Car
end

# We can enable the engine if we 
# turn the car on with the right key
car = Car.new
car.turn_on("foo")

# But we can't enable the engine directly
car.engine.engage

# Output:
# Engine turned on!
# Car turned on!
# export.rb:17:in `block in export': `engage' is not accessible outside 
# Engine (NoMethodError)
# 	from friends.rb:29:in `<main>'
