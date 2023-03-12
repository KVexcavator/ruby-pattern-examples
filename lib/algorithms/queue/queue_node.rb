
class Node
  attr_accessor :data, :next
  def initialize(data)
    @data = data
    @next = nil
  end
end

class Queue
  attr_accessor :front, :rear, :size

  def initialize
    @front = nil
    @rear = nil
    @size = 0
  end

  # добавить в конец очерещи
  def enqueue(item)
    @size += 1
    node = Node.new(item)
    if @rear == nil
      @front = node
      @rear = node
    else
      @rear.next = node
      @rear = node
    end
  end

  # удалить из начала очереди
  def dequeue
    return "pop from empty queue" if @front == nil
    @size -= 1
    temp = @front
    @front = @front.next
    if @front == nil
      @rear = nil
    end
    temp.data
  end

end

queue = Queue.new()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
p queue.size
3.times do
  p queue.dequeue
end
