# Есть  y,x сетка. Есть массив содержит высоту стенок которые растут из индексов по оси x вверх по y. Любые две стенки, основание и верхним основанием паралельным нижнему образуют прямоуголник (далее бассейн)
# Надо найти самый большой по площаци из возможных бассейнов
# Input: heights = [2,7,8,3,7,6]
# Output: 24

# высота [heights[i], heights[j]].min
# ширина j - i
# прямоугольник это произведение высоты на ширину

def largest_container_brute_force(heights)
  n = heights.length
  max_water = 0
  (0...n).each do |i|
    (i+1...n).each do |j|
      water = [heights[i], heights[j]].min * (j - i)
      max_water = [max_water, water].max
    end
  end
  p max_water
end
# здесь квадратичная сложность 
largest_container_brute_force([2,7,8,3,7,6])
puts "-------------------"
# в самом начале мы имеем максимальную ширину бассейна и дыва указателя левый i и правый j. 
# одна из высот меньше чем другая и может перейти к большей величене, так быстрее найти большую площадь
# если высоты равные, сдвиг не даст прироста площади, ширина сократится, а высота нет. в такой ситуации надо двигать оба указателя
# если между указателями один ход, высоту определяет наименьший
# когда указатели равны, нужно останавливать поиск

def largest_container(heights)
  max_water = 0
  left, right = 0, heights.length - 1
  while (left < right)
    water = [heights[left], heights[right]].min * (right - left)
    max_water = [max_water, water].max
    if (heights[left] < heights[right])
      left = left + 1
    elsif (heights[left] > heights[right])
      right = right - 1
    else
      left = left + 1
      right = right - 1
    end
  end
  p max_water
end
# временная сложность O(n), а пространственная O(1)
largest_container([2,7,8,3,7,6])