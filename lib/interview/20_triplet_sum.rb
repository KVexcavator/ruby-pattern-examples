# Дано массив целых чисел, вернуть все тройнички [a,b,c] для которых a+b+c=0. Рушение не должно содержать дубликаты, такие как [1,2,3] и [2,3,1]. Если ничего не найдено вернуть []
# Тройники можно вернуть влюбом порядке и порядке содержимого.
# Пример
# input nums = [0,-1,2,-3,1]
# output: [[-3,1,2],[-1,0,1]]

def triplet_sum_brute_force(nums)
  n = nums.length
  triplets = Set.new()
  (0...n).each do |i|
    (i+1...n).each do |j|
      (j+1...n).each do |k|
        if nums[i]+nums[j]+nums[k] == 0
          triplets.add([nums[i],nums[j],nums[k]].sort)
        end
      end
    end
  end
  p triplets.to_a
end

triplet_sum_brute_force([0,-1,2,-3,1])
triplet_sum_brute_force([])

puts "=================="
# Сложность решения Onв кубе
# для любого [a,b,c] истино a+b+c=0 -> b+c=-a, те можно применять решенике как для поиска пары, но для этого надо сперва отсортировать массив. Потом бы берем первый элемент и ищем к нему пару среди оставшихся, где цель первый элемент с обратным знаком
# нюанс здесь в обработке дубликатов
# первой причиной появления дубликатов могут быть одинаковые первые элементы[a,a,b,c], и этот случай обрабатывается в коде так:
# if i > 0 and nums[i]==nums[i-1]
# второй причиной повторяющееся вторые элементы [a,b,b,c], обрабатываются также
# третие элементы тоже могут повторяться [a,b,c,c], но этот случай не обрабатывается, так как предыдущее обработчики гарантируют уникалность [a,b]



def triplet_sum(nums)
  triplets = []
  nums = nums.sort
  (0...nums.length).each do |i|
    # важно, если тройник состоит только из положительных целых чисел, их сумма никогда не будет равна O
    break if nums[i] > 0
    next if i > 0 and nums[i]==nums[i-1]
    pairs = pair_sum_sorted_all_pairs(nums, i+1, -nums[i])
    pairs.each do |pair|
      triplets << [nums[i]] + pair
    end
  end
  p triplets
end

def pair_sum_sorted_all_pairs(nums, start, target)
  pairs = []
  left, right = start, nums.length - 1
  while left < right
    sum = nums[left] + nums[right]
    if sum == target
      pairs << [nums[left],nums[right]]
      left = left + 1
      while left < right and nums[left] == nums[left - 1]
        left = left + 1
      end
    elsif sum < target
      left = left + 1
    else
      right = right - 1
    end
  end
  p pairs
end

triplet_sum([0,-1,2,-3,1])
triplet_sum([])

# Сложность решения Onв квадрате