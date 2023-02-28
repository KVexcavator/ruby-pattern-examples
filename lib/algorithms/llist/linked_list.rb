# связанный список, каждфй элемент содержит ссылку, на следующий или следующий и предыдущий
# односвязный список — тип связного списка с указателями, которые указывают только на следующий элемент.
# для вставки элемента в связный список требуется корректировка двух указателей
# по односвязному списку можно перемещаться только от начала к концу, по двусвязному — и от начала к концу, и в обратном направлении; причем необязательно доходить каждый раз до конца (или начала) списка.
# в круговом связном списке последний узел указывает на первый узел, что позволяет переходить от последнего элемента списка обратно к началу

class Node
  attr_accessor :next
  attr_reader   :data

  def initialize (data)
    @data = data
    @next = nil
  end

  def to_s
    "Node: #{@data}"
  end
end

class LinkedList
  def initialize
    @head = nil
  end

  def append(data)
    if @head
      current = @head
      while current.next
        current = current.next
      end
      current.next = Node.new(data)
    else
      @head = Node.new(data)
    end
  end

  def search(target)
    current = @head
    while current.next
      return true if current.data == target
      current = current.next
    end
    false
  end

  def reverse
    current = @head
    previous = nil
    while current
      next_to = current.next
      current.next = previous
      previous = current
      current = next_to
    end
    @head = previous
  end

  def remove(target)
    if @head != target
      current = @head
      previous = nil
      while current
        if current.data == target
          previous.next = current.next
        end
        previous = current
        current = current.next
      end
    else
      @head = @head.next
    end
    target
  end

  # указывает ли последний элемент списка
  # алгоритмом черепахи и зайца.
  # перебор на двух разных скоростях, отслеживая узлы в переменной slow и в переменной fast. В случае кругового связного списка в конечном итоге переменная fast перекроет переменную slow и обе переменные будут одинаковы. Если подобное случилось, значит, список круговой.

  def detect_cycle
    slow = @head
    fast = @head
    while true
      begin
        slow = slow.next
        fast = fast.next.next
        return true if slow === fast
      rescue
        return false
      end
    end
  end

  def to_array
    current = @head
    arr = []
    while current
      pos = current.next
      arr << current.data
      current = pos
    end
    arr
  end

  def print
    node = @head
    puts node
    while (node = node.next)
      puts node
    end
  end
end

puts "init and append items:"
llist = LinkedList.new()
llist.append("Tuesday")
llist.append("Wednesday")
llist.append("Friday")
llist.print
puts "search:"
p llist.search("Monday")
p llist.search("Tuesday")
puts "remove:"
p llist.remove("Friday")
puts "reverse linked list:"
llist.reverse()
llist.print
puts "detect cycle"
p llist
p llist.detect_cycle
