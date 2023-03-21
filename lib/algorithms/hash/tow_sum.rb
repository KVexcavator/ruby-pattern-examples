# вернуть индексы двух чисел в неотсортированном списке, которые в сумме дают целевое значение

def tow_sum(list, target)
  dict = {}
  list.each_with_index do |n, index|
    rem = target - n
    if dict.has_key? rem
      return index, dict[rem]
    else
      dict[n] = index
    end
  end
end

p tow_sum([-1, 2, 3, 4, 7], 5)
