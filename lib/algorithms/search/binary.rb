def binary_search(list, n)
  first = 0
  last = list.length - 1
  while last >= first
    # целочисленное деление div(дробное fdiv)
    mid = (first + last).div(2)
    return true if list[mid] == n
    if  n < list[mid]
      last = mid - 1
    else
      first = mid + 1
    end
  end
  return false
end

p my_list = [1, 3, 5, 7, 9]
p binary_search(my_list, 3)
p binary_search(my_list, -1)
