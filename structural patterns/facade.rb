# https://medium.com/@dljerome/design-patterns-in-ruby-facade-a88e6b3949bb
# Фасад — это структурный паттерн проектирования, который предоставляет простой интерфейс к сложной системе классов, библиотеке или фреймворку.

module Texty
end

class Texty::Searcher
  def self.search(query)
    "searched #{query}"
  end
end

class Texty::Finder
  def self.find(phrase)
    "found #{phrase}"
  end
end

class Texty::Serializer
  def self.serialize(string)
    "serialized #{string}"
  end
end

class Texty::Facade

  def search(query)
    Texty::Searcher.search(query)
  end

  def find(phrase)
    Texty::Finder.find(phrase)
  end

  def serialize(string)
    Texty::Serializer.serialize(string)
  end
end

facade = Texty::Facade.new
facade.search("when in rome")
facade.find("city of love")
facade.serialize("the rain in spain")
