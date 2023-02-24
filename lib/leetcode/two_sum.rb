# Input: nums = [2,7,11,15], target = 9
# Output: [0,1]
# Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
def two_sum(nums, target, i_1=0)
  first = nums.shift
  i_2 = i_1 + 1
  nums.each do |num|
    if first + num == target
      return [i_1, i_2]
    end
    i_2 += 1
  end
  i_1 += 1
  two_sum(nums, target, i_1)
end

nums = [3,4,2]
target = 6
p two_sum(nums, target)

nums = [3,3]
target = 6
p two_sum(nums, target)

nums = [2,7,11,15]
target = 9
p two_sum(nums, target)

nums = [1,2,11,3,6]
target = 9
p two_sum(nums, target)

nums = [3,2,3]
target = 6
p two_sum(nums, target)
