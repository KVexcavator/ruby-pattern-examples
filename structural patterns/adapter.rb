# https://rubypatterns.dev/structural/adapter.html
# Адаптер — это структурный паттерн проектирования, который позволяет объектам с несовместимыми интерфейсами работать вместе.

class Antelope
  def length_in_millis
    2400
  end
end

class GrizzlyBear
  def length_in_inches
    78.7
  end
end

class AnimalAdapter
  MILLIMETRES_IN_AN_INCH = 25

  def initialize(animal)
    @animal = animal
  end

  def length_in_millis
    @animal.length_in_inches * MILLIMETRES_IN_AN_INCH
  end
end

bear = GrizzlyBear.new
adapted_bear = AnimalAdapter.new(bear)
adapted_bear.length_in_millis
#=> 1967.5
