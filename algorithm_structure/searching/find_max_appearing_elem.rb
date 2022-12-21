# В заданном массиве из n чисел найдите элемент, который встречается максимальное количество раз.
arry = [1,3,15,0,3,-4,25,-4,15,-4]
# O(n2)
def get_max_count_bad(arr)
  size = arr.size
  max = 0
  count = 0
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
    if count > maxCount
      max = arr[i]
      maxCount = count
    end
    count = 0
    i += 1
  end
  return max
end

p get_max_count_bad(arry)

# O(n.logn)
def get_max_count_sort(arr)
  arr = arr.sort()
  size = arr.size
  max = arr[0]
  maxCount = 1
  curr = arr[0]
  currCount = 1
  i = 1
  while i < size
    if arr[i] == arr[i - 1]
      currCount += 1
    else
      currCount = 1
      curr = arr[i]
    end
    if currCount > maxCount
      maxCount = currCount
      max = curr
    end
    i += 1
  end
  return max
end

p get_max_count_sort(arry)

# Подсчет, возможен только в том случае, если мы знаем диапазон ввода. Если мы это знаем, элементы в массиве находятся в диапазоне от 0 до n-1. Мы можем зарезервировать массив длины n, и когда мы увидим элемент, мы можем увеличить его количество. Всего за одно сканирование мы узнаем дубликаты
# O(n)
def get_max_count_range(arr, range)
  size = arr.size
  max = arr[0]
  maxCount = 1
  p count = Array.new( range +1, 0)
  i = 0
  while i < size
    p count[arr[i]]
    count[arr[i]] += 1
    if count[arr[i]] > maxCount
      maxCount = count[arr[i]]
      max = arr[i]
    end
    i += 1
  end
  return max
end

p get_max_count_range(arry, 5)
