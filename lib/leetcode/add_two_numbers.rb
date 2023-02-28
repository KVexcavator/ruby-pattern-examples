# 2. Add Two Numbers
# Вам даны два непустых связанных списка, представляющих два неотрицательных целых числа. Цифры хранятся в обратном порядке, и каждый из их узлов содержит одну цифру. Добавьте два числа и верните сумму в виде связанного списка.
# Вы можете предположить, что эти два числа не содержат начальных нулей, кроме самого числа 0.

# Input: l1 = [2,4,3], l2 = [5,6,4]
# Output: [7,0,8]
# Explanation: 342 + 465 = 807.

# Input: l1 = [0], l2 = [0]
# Output: [0]
# Example 3:

# Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
# Output: [8,9,9,9,0,0,0,1]

# Условия:

# Количество узлов в каждом связанном списке находится в диапазоне [1, 100].
# 0 <= Node.val <= 9
# Гарантируется, что список представляет собой число, не имеющее лидирующих нулей.

# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end

  def ListNode.from_array(arr)
    new(arr.shift,( ListNode.from_array(arr) if arr.length > 0 ))
  end

  def to_array
    arr = []
    current = self
    while current
      pos = current.next
      arr << current.val
      current = pos
    end
    arr
  end

end

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
  num = l1.to_array.reverse.join.to_i + l2.to_array.reverse.join.to_i
  arr = num.to_s.each_char.map(&:to_i).reverse
  ListNode.from_array(arr)
end

l1 = ListNode.from_array([2,4,3])
l2 = ListNode.from_array([5,6,4])
p add_two_numbers(l1,l2)
puts "-----------"
l1 = ListNode.from_array([0])
l2 = ListNode.from_array([0])
p add_two_numbers(l1,l2)
puts "-----------"
l1 = ListNode.from_array([9,9,9,9,9,9,9])
l2 = ListNode.from_array([9,9,9,9])
p add_two_numbers(l1,l2)
puts "-----------"
