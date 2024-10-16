# Тот самый случай, когда Gear является частью внешнего интерфейса module SomeFramework
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel

    def initialize(chainring, cog, wheel=nil)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end

    def ratio
      chainring / cog.to_f
    end

    def gear_inches
      ratio * wheel.diameter
    end
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
  end
end

# заключение интерфейса в оболочку для вашей защиты от изменений
module GearWrapper
  def self.gear(args)
    SomeFramework::Gear.new(
      args[:chainring],
      args[:cog],
      args[:wheel]
    )
  end
end

# Теперь новый экземпляр Gear можно создавать, используя хеш аргументов
p GearWrapper.gear({
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(25, 2.1)
}).gear_inches