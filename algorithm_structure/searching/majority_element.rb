# Дан массив из n элементов. Найдите мажоритарный элемент, который встречается более n/2 раз. Возвращает 0, если мажоритарного элемента нет.
a = %w(33 2 61 33 33)
# O(n2)
def get_majority(arr)
  size = arr.size
  max = 0
  count = 1
  maxCount = 0
  i = 0
  while i < size
    j = i + 1
    while j < size
      if arr[i] == arr[j]
        count += 1
      end
      j += 1
    end
    if count > size / 2
      return p arr[i]
    end
    count = 1
    i += 1
  end
  print "no majority found"
  return -1
end

get_majority(a)

# O(n.logn)
def get_majority_sort(arr)
  arr = arr.sort()
  size = arr.size
  maj_index = size / 2
  count = 1
  candidate = arr[maj_index]
  count = 0
  i = 0
  while i < size
    if arr[i] == candidate
      count += 1
    end
    i += 1
  end
  if count > size / 2
    return p arr[maj_index]
  else
    print "no majority found"
    return -1
  end
end

get_majority_sort(a)
