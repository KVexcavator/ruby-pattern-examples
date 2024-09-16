# Команда — это поведенческий паттерн проектирования,который превращает запросы в объекты, позволяя передавать их как аргументы при вызове методов, ставить запросы в очередь, логировать их, а также поддерживать отмену операций.

# Интерфейс для команды
module Command
  def execute
    raise NotImplementedError, 'execute method must be implemented'
  end
end

# Класс для света
class Light
  def on
    puts "Свет включен."
  end

  def off
    puts "Свет выключен."
  end
end

# Класс для пульта управления
class RemoteControl
  attr_accessor :command

  def press_button
    command.execute
  end
end

# Команда для включения света
class LightOnCommand
  include Command

  def initialize(light)
    @light = light
  end

  def execute
    @light.on
  end
end

# Команда для выключения света
class LightOffCommand
  include Command

  def initialize(light)
    @light = light
  end

  def execute
    @light.off
  end
end

# Демонстрация паттерна "Команда"
light = Light.new
remote = RemoteControl.new

# Установка команды включения света
remote.command = LightOnCommand.new(light)
remote.press_button

# Установка команды выключения света
remote.command = LightOffCommand.new(light)
remote.press_button
