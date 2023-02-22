# ищем совпадения
def return_intersection(list1, list2)
  list = []
  list1.each do |item|
    list << item if list2.include? item
  end
  list
end

def return_intersection_with_set(list1, list2)
  (Set.new(list1) & Set.new(list2)).to_a
end

list1 = [2, 43, 48, 62, 64, 28, 3]
list2 = [1, 28, 42, 70, 2, 10, 62, 31, 4, 14]
p return_intersection(list1, list2)
p return_intersection_with_set(list1, list2)
p list1 & list2
