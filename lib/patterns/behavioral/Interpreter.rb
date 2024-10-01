# Паттерн Интерпретатор (Interpreter) используется для интерпретации или вычисления выражений в каком-либо языке. Он подходит для создания простого языка, грамматики или системы команд. Каждое правило языка реализуется в виде отдельного класса, который обрабатывает выражение и возвращает результат. Этот паттерн полезен, когда у нас есть множество подобных выражений, которые нужно интерпретировать.

# Контекст, который хранит информацию о животном
class AnimalContext
  attr_accessor :animal

  def initialize(animal)
    @animal = animal
  end
end

# Общий интерфейс для всех выражений
class Expression
  def interpret(context)
    raise NotImplementedError, "This method should be overridden in subclasses"
  end
end

# Конкретное выражение для действия "идти"
class WalkExpression < Expression
  def interpret(context)
    puts "#{context.animal} идет"
  end
end

# Конкретное выражение для действия "есть"
class EatExpression < Expression
  def interpret(context)
    puts "#{context.animal} ест"
  end
end

# Конкретное выражение для действия "спать"
class SleepExpression < Expression
  def interpret(context)
    puts "#{context.animal} спит"
  end
end

# Класс для интерпретирования команды
class AnimalInterpreter
  def initialize(command)
    @command = command.downcase
  end

  def interpret(animal)
    context = AnimalContext.new(animal)

    case @command
    when 'идти'
      WalkExpression.new.interpret(context)
    when 'есть'
      EatExpression.new.interpret(context)
    when 'спать'
      SleepExpression.new.interpret(context)
    else
      puts "Неизвестная команда: #{@command}"
    end
  end
end

# Использование

interpreter = AnimalInterpreter.new("идти")
interpreter.interpret("Котик") # Котик идет

interpreter = AnimalInterpreter.new("есть")
interpreter.interpret("Пёс") # Пёс ест

interpreter = AnimalInterpreter.new("спать")
interpreter.interpret("Кролик") # Кролик спит
