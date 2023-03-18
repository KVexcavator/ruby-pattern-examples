# https://ruby-doc.org/core-3.0.0/Queue.html

# встроенный в ruby класс

queue = Queue.new()
p queue.push("a")
queue.push("b")
queue << "c"
p queue.pop
p queue.size

queue = Queue.new # creates a new Queue object
queue.enqueue(Monday) # adds Monday to the queue
queue.enqueue(Tuesday) # adds Tuesday to the queue
queue.enqueue(Wednesday) # adds Wednesday to the queue
queue.dequeue # removes Monday from the queue
queue.size # returns 2 which is the number of items in the queue
