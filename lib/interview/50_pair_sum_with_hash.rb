# вернуть индексы целевой суммы
# input: nums = [-1,3,4,2], target = 3
# output: [0,2]

# решение с одним проходом, без формирования хеша заранее, сразу сравниваем ключ и результат вычтания из целевой суммы

def pair_sum_unsorted(nums, target, res = [])
  hashmap = {}
  nums.each_with_index do |x, i|
    if hashmap.key?(target - x)
      p res = [hashmap[target - x], i]
      return res
    end
    hashmap[x]= i
  end
  p res
end

pair_sum_unsorted([-1,3,4,2], 3)