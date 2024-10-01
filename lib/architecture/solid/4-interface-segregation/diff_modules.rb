# Модули в Ruby можно разбить на несколько частей, чтобы подключать только нужные функциональные компоненты.

module Speakable
  def speak
    puts "Мяу!"
  end
end

module Runnable
  def run
    puts "Котик бежит!"
  end
end

class Cat
  include Speakable  # Подключаем только модуль с методом speak
end

cat = Cat.new
cat.speak  # Выведет: Мяу!
cat.run    # Ошибка: undefined method `run'


