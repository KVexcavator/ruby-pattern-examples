# https://ruby-doc.org/core-3.0.0/Queue.html

# встроенный в ruby класс

queue = Queue.new()
p queue.push("a")
queue.push("b")
queue << "c"
p queue.pop
p queue.size
