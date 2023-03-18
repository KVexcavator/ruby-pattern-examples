# Deque (или двусторонняя очередь) — это упорядоченный последовательный набор объектов, который позволяет извлекать, добавлять и удалять элементы в начале и в конце последовательности за постоянное время. Это делает Deque идеальным для использования в качестве неизменной очереди или стека.

class Deque
  attr_reader :items

  def initialize
    @items = []
  end

  def add_front(item)
    @items.push(item)
  end

  def add_rear(item)
    @items.unshift(item)
  end

  def remove_front
    @items.pop
  end

  def remove_rear
    @items.shift
  end

  def size
    @items.length
  end
end

# Построение с нодами
# https://betterprogramming.pub/implementing-a-deque-in-ruby-cf6e9bfd9c3c

# Есть встроееный в ruby
# https://www.rubydoc.info/github/immutable-ruby/immutable-ruby/Immutable/Deque#:~:text=Overview,an%20immutable%20queue%20or%20stack.
# create deque
Immutable::Deque.new([:first, :second, :third])
Immutable::Deque[1, 2, 3, 4, 5]
# example deque
deque = Immutable::Deque.empty # => Immutable::Deque[]
deque = deque.push('a').push('b').push('c')  # => Immutable::Deque['a', 'b', 'c']
deque.first  # => 'a'
deque.last   # => 'c'
deque = deque.shift # => Immutable::Deque['b', 'c']
