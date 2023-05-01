# принуждение

class TimeInterval
  attr_reader :value # in total seconds

  def initialize(value)
    @value = value.to_i
  end

  def self.parse(string)
    minutes, seconds = string.split(':').map(&:to_i)
    new((minutes * 60) + seconds)
  end

  def minutes
    value / 60
  end

  def seconds
    value % 60
  end

  def to_s
    "#{minutes}:#{seconds}"
  end
 end
 # Now we’re able to create a new TimeInterval by either calling TimeInterval.new and pass the number of total seconds, or I can call TimeInterval.parse and pass a string. The to_s function works well enough for our purposes.

 TimeInterval.new(75)
 #<0xb758bb5c value="75">
 TimeInterval.parse("1:15")
 #<0xb7587fe8 value="75">
 TimeInterval.parse("1:15").to_s
 # "1:15"

 # пример из доков Grape

 class Color
  attr_reader :value
  def initialize(color)
    @value = color
  end

  def self.parse(value)
    return new(value) if %w[blue red green]).include?(value)

    Grape::Types::InvalidValue.new('Unsupported color')
  end
end
