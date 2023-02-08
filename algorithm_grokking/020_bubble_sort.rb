def bubble_sort(list)
  length = list.length - 1
  (0...length).each do
    (0...length).each do |i|
      if list[i] > list[i + 1]
        list[i], list[i + 1] = list[i + 1], list[i]
      end
    end
  end
  list
end

p arr = [1,9,6,32,74,2,1]
p bubble_sort(arr)
