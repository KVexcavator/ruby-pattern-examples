# Необходмо разработать код на Ruby, получающий на вход количество дисков, исходную, целевую и список запрещенных комбинаций и выводящую последовательность комбинаций от начальной до конечной, минуя запрещенные, или выводящий сообщение, что решения нет. Если возможных последовательностей несколько - необходимо вывести любую из них(не обязательно наикратчайшую).

# Например, при входных данных:
# DISC_COUNT = 3
# from = [0, 0, 0]
# to = [1, 1, 1]
# exclude = [[0, 0, 1], [1, 0, 0]]
# пример решения:
# [0, 0, 0]
# [0, 1, 0]
# [1, 1, 0]
# [1, 1, 1]

class LockNode
  attr_accessor :value
  attr_reader :children
  BRANCHES = []

  def initialize(value)
    @value = value
    @children = []

    value.each_with_index do |e,i|
      n = i + 1

      first = value.map(&:clone)
      first[i] = (first[i] + 1 if first[i].between?(0,8)) || 0

      second = value.map(&:clone)
      second[i] = (second[i] - 1 if second[i].between?(1,9)) || 9

      BRANCHES << name = "branch_#{n}"
      instance_variable_set("@#{name}", first)
      BRANCHES << name = "branch_#{n += value.size}"
      instance_variable_set("@#{name}", second)
      @children << first << second
    end
  end

  def LockNode.full(value)
    node = new(value)
    BRANCHES.each do |name|
      node.instance_eval { class << self; self end }.send(:attr_accessor, name)
    end
    node
  end

end



class SearchTree

  def self.plant(root, target, excluded )
    # base
    node = LockNode.full(root)
    p parrent = node.value
    children = node.children
    children = children.select do |value|
      !excluded.include?(value)
    end
    if children.include?(target)
      p target
      print "Done!"
      return
    end

    # find next node
    next_node = parrent
    target.each_with_index do |value ,index|
      pass = children.select {|item| item[index] != parrent[index]}
      begin
        if pass.size == 2
          next_node[index] = value
          # ckeck
          if excluded.include?(next_node)
            next_node[index] = pass.last[index]
          end
          # recursi
          plant(next_node, target, excluded)
          return
        end
      rescue
        puts "NO PATH"
      end
    end
  end

end


DISC_COUNT = 3
from = [9, 0, 0]
to = [1, 1, 1]
excluded = [[0, 0, 1], [1, 0, 0]]

path = SearchTree.plant(from, to, excluded)
