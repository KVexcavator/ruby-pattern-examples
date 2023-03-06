
class StackArray
  def initialize
    $items = []
  end

  def push(data)
    $items.push(data)
  end

  def pop
    $items.pop
  end

  def size
    $items.length
  end

  def is_empty?
    $items.length == 0
  end

  def peek
    $items[-1]
  end
end

sa = StackArray.new
p sa.is_empty?
sa.push("book_1")
sa.push("book_2")
sa.push("book_3")
p sa
p sa.pop
p sa.size
p sa.peek
