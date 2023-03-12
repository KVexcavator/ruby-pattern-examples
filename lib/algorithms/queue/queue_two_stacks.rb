# создание очереди с помощью двух стеков

class Queue
  def initialize
    @s1 = []
    @s2 = []
  end

  def enqueue(item)
    while @s1.length != 0
      @s2 << @s1.pop
    end
    @s1 << item
    while @s2.length !=0
      @s1 << @s2.pop
    end
  end

  def dequeue
    return "Cannot pop from empty queue" if @s1.length == 0
    @s1.pop
  end
end

queue = Queue.new()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
p queue
3.times do
  p queue.dequeue
end
