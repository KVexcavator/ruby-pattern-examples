# Одиночка — это порождающий паттерн проектирования, который гарантирует, что у класса есть только один экземпляр, и предоставляет к нему глобальную точку доступа.

require 'singleton'

class Loger
  include Singleton

  def initialize
    @f=File.open 'log.txt', 'a'
  end

  def log_something what
    @f.puts what
    @f.flush
  end

end

Loger.instance.log_something 'Attention! Balmaley go-go!'
