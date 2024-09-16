# instance_eval в Ruby — это метод, который позволяет выполнять код в контексте конкретного объекта, изменяя текущий объект self внутри блока на тот, на котором был вызван instance_eval. Этот метод часто используется для доступа к закрытым методам и переменным экземпляра или для динамического выполнения кода внутри объекта.

# Доступ к переменным экземпляра:
class Camel
  def initialize(name)
    @name = name
  end
end

camel = Camel.new("Barbambia")
# Мы не можем напрямую получить доступ к @name, так как она приватная.
puts camel.instance_eval { @name }  # => "Barbambia"

# Определение методов на уровне объекта:
dog = Object.new
dog.instance_eval do
  def bark
    "Woof!"
  end
end

puts dog.bark # => "Woof!"


# Красивая инициализация
class Cat

	def initialize(&block) 
		instance_eval &block
	end

	def name(str)
		puts str
	end
end

# Фишка в том, что у нас нет |s| в определении метода
cats = Cat.new do 
	name "Basilio"
end

