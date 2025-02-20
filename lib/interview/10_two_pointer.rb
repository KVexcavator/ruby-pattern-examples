# подход с двумя указателями применяется, применяется когда надо проийти по массиву или связанному списку
# пример задачи
# eсть упорядоченный по возрастанию массив и  целевая сумма двух элементов, нужно вернуть любой массив индексов или пустой
# nums = [-5, -2, 3, 4, 6],  target = 7
# => [2, 3] ; nums[3] + nums[4] = 7

def pair_sum_sorted_brute_force(arr, target, result = [])
  n = arr.length
  (0...n).each do |i|
    j = i + 1
    (j...n).each do |j|
      if arr[i] + arr[j] == target
        p result = [i, j] 
        return
      end
    end
  end
  p result
end

pair_sum_sorted_brute_force([-5, -2, 3, 4, 6], 7)

# для улучшения лучше всего правый указатель поставить где наибольщее, а левый где наименьшее, они движутся навстречу друг другу

def pair_sum_sorted(arr, target, result = [])
  left, right = 0, arr.length - 1
  while left < right
    sum = arr[left] + arr[right]
    if sum < target
      left = left + 1
    elsif sum > target
      right = right - 1
    else
      p result = [left, right]
      return
    end
  end
  p result
end

pair_sum_sorted([-5, -2, 3, 4, 6], 7)
pair_sum_sorted([], 0)
pair_sum_sorted([1], 1)
pair_sum_sorted([2,4], 5)