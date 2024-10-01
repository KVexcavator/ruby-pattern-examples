#coding: utf-8
# Найдите непрерывный подмассив в массиве (содержащем как минимум 1 элемент),
# который имеет максимальную сумму элементов.
# Пример: [-1, -13, -2, 1, -3, 4, -1, 2, 1, -5, 4] должно вернуть [4, -1, 2, 1].
# Kadane's algoritm

def max_subarray(nums)
  best_start = best_end = 0
  best_sum = current_sum = -1.0/0 # -Infinity
  index_start = 0
  nums.each_with_index do |n, index_end|
    # для отладки индексов
    # puts "#{index_end} is #{n}"
    if current_sum <= n 
      index_start = index_end 
      current_sum = n
    else
      current_sum +=n 
    end

    if current_sum > best_sum
      best_sum = current_sum 
      best_start = index_start
      best_end = index_end 
    end
  end
  # puts "Best sum = #{best_sum}, Best start = #{best_start}, Best end = #{best_end}."
  p nums[best_start..best_end]
end

arr1 = [-1, -13, -2, 1, -3, 4, -1, 2, 1, -5, 4]
max_subarray arr1
arr2 = [-1, -13, -2, 1, -3, 4, -1, 2, 1, -5, 4, -100, 22]
max_subarray arr2
