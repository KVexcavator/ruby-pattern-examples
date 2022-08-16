# https://gist.github.com/dljerome/b31f467b9e674c71f58006e0365c2393#file-flyweight_pattern-rb
# Легковес — это структурный паттерн проектирования, который позволяет вместить бóльшее количество объектов в отведённую оперативной память за счёт экономного разделения общего состояния объектов между собой, вместо хранения одинаковых данных в каждом объекте.

class Animal
  attr_reader :title

  def initialize(title)
    @title = title
  end
end

class AnimalFactory
  def initialize
    @zoo = {}
  end

  def find_animal(title)
    if @zoo.has_key?(title)
      animal = @zoo[title]
    else
      animal = create_animal(title)
      @zoo[title] = animal
    end
    animal
  end

  def zoo_size
    @zoo.size
  end

  private

  def create_animal(title)
    Animal.new(title)
  end
end

class Circus
  attr_reader :animal_factory

  def initialize
    @animal_factory = AnimalFactory.new
    @perfomance = []
  end

  def add_animal(title)
    animal = @animal_factory.find_animal(title)
    @perfomance << animal
  end

  def perfomance_up
    @perfomance.inject("&&&") do |result, animal|
      result << animal.title + "***"
    end
  end
end


circus = Circus.new

# Next, we add amimals to the perfomance.
circus.add_animal("tiger")
circus.add_animal("monkey")
circus.add_animal("tiger")
circus.add_animal("monkey")
circus.add_animal("tiger")

puts circus.perfomance_up # &&&tiger***monkey***tiger***monkey***tiger***

puts circus.animal_factory.zoo_size # 2
