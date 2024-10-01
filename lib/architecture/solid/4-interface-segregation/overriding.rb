# Можно преопределить методы, которые не нужно использовать, и сделать их приватными или пустыми.

module Animal
  def speak
    puts "Мяу!"
  end

  def run
    puts "Котик бежит!"
  end
end

class Cat
  include Animal

  private

  def run
    # Переопределили метод, чтобы он ничего не делал
  end
end

cat = Cat.new
cat.speak  # Выведет: Мяу!
cat.run    # Не будет выводить ничего, так как метод пуст
