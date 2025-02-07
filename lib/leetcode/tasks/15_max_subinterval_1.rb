# Дан массив из нулей и единиц. Нужно определить, какой максимальный по длине подинтервал единиц можно получить, удалив ровно один элемент массива. Вернуть 0, если такого подинтервала не существует. Удаление элемента обязательно.

def max_subinterval_ones(arr, nil_pos)
  arr.delete_at(nil_pos)
  len = 0
  lens = []
  arr.each_with_index do |ell, index|
    if ell == 0
      lens << len if len > 0
      len = 0
      next
    end
    len +=1
    lens << len if index == (arr.size - 1)
  end
  p lens
  p lens.max || 0
end


arr1 = [1, 1, 0, 1, 1, 1]
# Ответ: 5
max_subinterval_ones(arr1,2)

arr2 = [1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1]
# Ответ: 6
max_subinterval_ones(arr2,6)

arr3 = [0, 0, 0]
# Ответ: 0
max_subinterval_ones(arr3,20)
