# только с проталкиванием и выталкиванием

class Node
  attr_accessor :data, :next
  def initialize(data)
    $data = data
    $next = nil
  end
end

class StackNode

  attr_accessor :root, :last, :size, :data

  def initialize
    @root = nil
    @last = nil
    @size = 0
  end

  def push(data)
    new_node = Node.new(data)
    if !@root
      @root = new_node
      @last = new_node
    else
      old_head = @root
      @root = new_node
      new_node.next = old_head
    end
    @size += 1
  end

  def pop
    return  "pop from empty stack" if @size == 0
    old_head = @root
    if @root == @last
      @last = nil
    end
    @root = @root.next
    @size -= 1
    old_head
  end

  def is_empty?
    !@root
  end

  def peek
    @root
  end
end

sn = StackNode.new()
p sn.is_empty?
p sn.pop
sn.push("book_1")
sn.push("book_2")
sn.push("book_3")
p sn
p sn.peek
p sn.pop
