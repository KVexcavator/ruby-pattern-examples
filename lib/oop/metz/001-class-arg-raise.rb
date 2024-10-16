class Dog
  ALLOWED_KEYS = [:name, :age]  # Допустимые ключи

  attr_accessor :name, :age
  
  def initialize(**arg)
    # Проверяем на наличие недопустимых ключей
    unknown_keys = arg.keys - ALLOWED_KEYS
    if unknown_keys.any?
      raise ArgumentError, "Unknown argument(s): #{unknown_keys.join(', ')}"
    end

    @name = arg.fetch(:name) { raise ArgumentError, "Name is required" }
    @age = arg.fetch(:age) { raise ArgumentError, "Age is required" }
  end
  
  def bark
    puts "GAV"
  end
end

# Правильный вызов
# dog = Dog.new(name: "Linux", age: 3)
# puts dog.name  # => "Linux"
# puts dog.age   # => 3

# Неправильный вызов: вызовет ArgumentError с сообщением "Name is required"
# dog = Dog.new(age: 3)

# Лишний аргумент вызовет исключение
# dog = Dog.new(name: "Linux", age: 3, color: "brown")

dog = Dog.new(name: "Linux", color: "brown")
