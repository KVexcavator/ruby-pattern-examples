#Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
#You may assume that each input would have exactly one solution, and you may not use the same element twice.
#You can return the answer in any order.
#Example 1:
#Input: nums = [2,7,11,15], target = 9
#Output: [0,1]
# Because nums[0] + nums[1] == 9, we return [0, 1].


# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target, output=[])
  nums.each_with_index do |num,i|
    diff = target - num
    next if not nums.include? diff  or nums.index(diff) == i 
    while output.length < 2
      output << i
      output << nums.index(diff)
    end
  end
  output
end

p two_sum([2,11,15,7], 9)
