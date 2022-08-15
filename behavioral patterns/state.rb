# https://gist.github.com/travisjeffery/2014395
# Состояние — это поведенческий паттерн проектирования, который позволяет объектам менять поведение в зависимости от своего состояния. Извне создаётся впечатление, что изменился класс объекта.

class Person
  attr_accessor :state, :name

  def initialize name, state = PersonStateHappy
    @state = state.new self
    @name = name
  end

  def state= new_state
    @state = new_state.new self
  end

  def activity
    "#{@state.listen_to_music} and #{@state.watch_movie}"
  end
end

class PersonState
  def initialize person
    @person = person
  end

  def listen_to_music
  end

  def watch_movie
  end
end

class PersonStateHappy < PersonState
  def listen_to_music
    "#{@person.name} is listening to Girls Just Want to Have Fun by Cyndi Lauper"
  end

  def watch_movie
    "#{@person.name} is watching Toy Story"
  end
end

class PersonStateSad < PersonState
  def listen_to_music
    "#{@person.name} is listening to Goodbye Blue Sky by Pink Floyd"
  end

  def watch_movie
    "#{@person.name} is watching The Green Mile"
  end
end

travis =  Person.new("Travis")
puts travis.activity

travis.state = PersonStateSad
puts travis.activity
