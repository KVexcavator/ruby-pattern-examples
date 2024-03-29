# https://www.youtube.com/watch?v=73r3KWiEvyk&list=PLot-Xpze53ldVwtstag2TL4HQhAnC8ATf&index=21
# Вы профессиональный грабитель, планирующий ограбить дома вдоль улицы. В каждом доме спрятана определенная сумма денег, единственное ограничение, мешающее вам ограбить каждый из них, заключается в том, что в соседних домах подключены системы безопасности, и она автоматически свяжется с полицией, если два соседних дома будут взломаны в одну и ту же ночь.
# Учитывая целочисленный массив nums, представляющий сумму денег в каждом доме, верните максимальную сумму денег, которую вы можете ограбить сегодня вечером, не предупредив полицию.
# Input: nums = [1,2,3,1]
# Output: 4
# Объяснение: ограбить дом 1 (деньги = 1), а затем ограбить дом 3 (деньги = 3).Общая сумма, которую вы можете ограбить = 1 + 3 = 4.

# @param {Integer[]} nums
# @return {Integer}
def rob(nums)
  win_1, win_2 = 0, 0
  # [win_1, win_2, n, n+1, ...]
  nums.each do |num|
    step = [win_1 + num, win_2].max
    win_1 = win_2
    win_2 = step
  end
  win_2
end

# Output: 4
nums = [1,2,3,1]
p rob(nums)

# Output: 12
nums = [2,7,9,3,1]
p rob(nums)

# Output: 4
nums = [2,1,1,2]
p rob(nums)
