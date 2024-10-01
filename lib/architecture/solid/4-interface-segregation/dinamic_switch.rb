# Можно подключать модули динамически в зависимости от условий или контекста.

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
  include Speakable

  def initialize(run_enabled = false)
    extend Runnable if run_enabled  # Подключаем модуль динамически
  end
end

cat1 = Cat.new
cat1.speak  # Выведет: Мяу!
cat1.run    # Ошибка: undefined method `run'

cat2 = Cat.new(true)
cat2.speak  # Выведет: Мяу!
cat2.run    # Выведет: Котик бежит!
