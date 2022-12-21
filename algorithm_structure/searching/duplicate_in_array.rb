require 'set'

arr = %w(10 14 1 7 9 1 14)
# O(n2)

def print_repeating_bad(arr)
  size = arr.size
  print " Repeating elements are "
  i = 0
  while i < size
    j = i + 1
     while j < size
      if arr[i] == arr[j]
        print " " , arr[i]
      end
      j += 1
    end
    i += 1
  end
end

print_repeating_bad(arr)

#  O(n log n)
def print_repeating_sort(arr)
  size = arr.size
  arr = arr.sort()
  print " Repeating elements are "
  i = 1
  while i < size
    if arr[i] == arr[i - 1]
      print " " , arr[i]
    end
    i += 1
  end
end

print_repeating_sort(arr)

# O(n)

def print_repeating_hash_table(arr)
  size = arr.size
  set = Set.new
  print " Repeating elements are "
  i = 0
  while i < size
    if set.include?(arr[i])
      print " " , arr[i]
    else
         set.add(arr[i])
    end
    i += 1
  end
end

print_repeating_hash_table(arr)
