# правилный подход с фабриками - подключать модули а не классы
# https://www.sitepoint.com/solving-design-anti-patterns-in-ruby-fix-the-factory/

class Shape
  attr_accessor :type
  def initialize(*args)
    @type = []
  end
end

module Triangle
  def draw
    "drawing triangle"
  end
  def self.extended(mod)
    mod.type << :Triangle
  end
end

module Square
  def draw
   "drawing square"
  end
  def self.extended(mod)
    mod.type << :Square
  end
end

module ThreeD
  def self.extended(mod)
    mod.type << :ThreeD
    case mod.type.first
    when :Triangle
      mod.instance_eval do
        def draw(depth)
          puts "drawing a Wedge"
        end
      end
    when :Square
      mod.instance_eval do
        def draw(depth)
          puts "drawing a Box"
        end
      end
    end
  end
end


triangle = Shape.new( 3, 2, 45).extend(Triangle)
puts triangle.type
# => Triangle

my_shape = Shape.new( 3, 2, 45).extend(Triangle).extend(Square)
puts my_shape.type
# => Triangle Square

sq = Shape.new.extend(Square)
puts sq.draw
# =>  drawing square
sq.extend(ThreeD)
puts sq.draw(4)
# => drawing a Box
puts sq.type
# => Square ThreeD
