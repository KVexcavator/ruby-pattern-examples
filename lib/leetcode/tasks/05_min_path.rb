#coding: utf-8
# Дан треугольник. Найдите минимальный путь от вершины до основания. 
# На каждом шаге вы можете двигаться только на соседние цифры, находящиеся в ряду ниже.
# Пример:
# [
#    [2],
#   [3,4],
#  [6,5,7],
# [4,1,8,3]
#]
# Здесь длина минимального пути от вершины до основания равна 11 (т.к 2+3+5+1 = 11).
# золотой треугольник colden_pyramid

triangle1 = [[2],[3,4],[6,5,7],[4,1,8,3]] # 2+3+5+1 = 11
triangle2 = [[2],[3,1],[1,5,5],[4,1,8,1]] # 2+3+1+1 = 7
# плохое решение(О большое в степени n) другого пока нет у меня
def min_path(arr, row=0, column=0, total=0)
  if row == arr.length - 1
    return total + arr[row][column]
  end
  return [min_path(arr, row+1, column, total+arr[row][column]), min_path(arr, row+1, column+1, total+arr[row][column])].min
end

puts min_path triangle1
puts min_path triangle2
