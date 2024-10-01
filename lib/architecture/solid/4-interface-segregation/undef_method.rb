# можно подключить модуль с помощью extend или include, а затем отключить не неужные методы. 

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

  # Убираем метод run, который не нужен
  undef_method :run
end

cat = Cat.new
cat.speak  # Выведет: Мяу!
cat.run    # Ошибка: undefined method `run' for #<Cat:...>
