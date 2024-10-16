# Композиция в объектно-ориентированном программировании  подразумевает "сильную" связь, при которой объект не может существовать без объекта-владельца. 

class Engine
  def initialize
    puts "Двигатель создан"
  end

  def start
    puts "Двигатель запущен"
  end
end

class Car
  def initialize
    @engine = Engine.new # Двигатель создается в момент создания машины
  end

  def start_car
    @engine.start
    puts "Машина поехала"
  end
end

# Точка входа в программу
car = Car.new
car.start_car
