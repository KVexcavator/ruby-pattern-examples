# сортировка вставками
def insertion_sort(list)
  list.length.times do |i|
    value = list[i]
    while i > 0 and list[i - 1] > value
      list[i] = list[i - 1]
      i = i - 1
      list[i] = value
    end
  end
  list
end

p arr = [6, 5, 8, 2, 9, 6, 1]
p insertion_sort(arr)
