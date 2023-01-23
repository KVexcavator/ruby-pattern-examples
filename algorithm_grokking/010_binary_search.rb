def binary_search(list, item)
  low = 0
  high = list.length - 1
  while low <= high
    mid = (low + high)
    guess = list[mid]
    if guess == item
      return puts mid
    elsif guess > item
      high = mid - 1
    else
      low = mid + 1
    end
  end
  return puts "None"
end


my_list = [1, 3, 5, 7, 9]
binary_search(my_list, 3)
binary_search(my_list, -1)
