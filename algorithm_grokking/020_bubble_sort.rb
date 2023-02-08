def bubble_sort(list)
  len = list.length - 1
  len.times do |i|
    no_swaps = true
    (len - i).times do |j|
      if list[j] > list[j + 1]
        list[j], list[j + 1] = list[j + 1], list[j]
        no_swaps = false
      end
    end
    return list if no_swaps == true
  end
end

p arr = [1,9,6,32,74,2,1]
p bubble_sort(arr)
