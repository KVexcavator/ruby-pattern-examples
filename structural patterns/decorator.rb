# https://gist.github.com/dljerome/899119ffd40911bfb0c571c1554dd1ac#file-decorator_pattern-rb
# Декоратор — это структурный паттерн проектирования, который позволяет динамически добавлять объектам новую функциональность, оборачивая их в полезные «обёртки».

class Coffee
  attr_accessor :price

  def price
    2.50
  end
end

class CoffeeWithCream

  def initialize(coffee)
    @coffee = coffee
  end

  def price
    @coffee.price += 0.50
  end
end

class CoffeeWithSugar

  def initialize(coffee)
    @coffee = coffee
  end

  def price
    @coffee.price += 0.25
  end

  def weekend_price
    @coffee.price += 1.25
  end
end

coffee = Coffee.new
coffee = CoffeeWithCream.new(coffee)
coffee = CoffeeWithSugar.new(coffee)
puts coffee.price # 3.25
puts coffee.weekend_price # 4.25
