# изоляция при создании в initialize @wheel = Wheel.new(rim, tire)
# изоляция явным определением в теле класса def wheel; @wheel ||= Wheel.new(rim, tire); end 
# изоляция внешних сообщений в теле класса def diameter; wheel.diameter; end
# устранение зависимостей от порядка следования аргументов

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(**args)
    @chainring = args.fetch(:chainring, 40)
    @cog       = args.fetch(:cog, 18)
    @wheel     = args[:wheel]
  end

  def ratio
    chainring / cog.to_f
  end

  def diameter
    wheel.diameter
  end

  def gear_inches
    ratio * diameter
  end  
end

class Wheel
  attr_reader :rim, :tire

  def initialize(**args)
    # указание значений по умолчанию поглощением хэша значений по умолчанию
    args = defaults.merge(args)
    @rim = args[:rim]
    @tire = args[:tire]
  end

  def diameter
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
  end

  def defaults
    {rim: 20, tire: 1.1}
  end
end

# или args = {} в инициализатор поередавать, или аргументы эешом
wheel = Wheel.new(rim: 25, tire: 1.5)
puts wheel.circumference
puts Gear.new(chainring: 52, cog: 11, wheel: wheel).gear_inches
puts Gear.new(chainring: 52, cog: 11).ratio