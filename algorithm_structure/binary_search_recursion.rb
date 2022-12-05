def binary_search_recursive(arr, value)
  return binary_searche_util(arr, 0, arr.size, value)
end

def binary_searche_util(arr, low, high, value)
  if low > high
    return false
  end
  mid = low + (high - low) / 2 # To avoid the overflow
  if arr[mid] == value then
    return true
  elsif arr[mid] < value then
    return binary_searche_util(arr, mid + 1, high, value)
  else
    return binary_searche_util(arr, low, mid - 1, value)
  end
end

# Testing Code
arr = [1,3,5,6,8,9,11,14,17,18]
puts binary_search_recursive(arr, 9)
puts binary_search_recursive(arr, 7)
