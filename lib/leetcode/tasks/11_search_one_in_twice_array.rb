# Given a non-empty array of integers, every element appears twice except for one. Find that single one.
ar = [4,1,2,1,2,4,5]
def single_number(n=0,nums)
  if n==0
    sort_nums = nums.sort
  else
    sort_nums = nums
  end  
  if (sort_nums[n] != sort_nums[n+1]) or (sort_nums[n] == sort_nums.last)
    puts sort_nums[n]
  else
    single_number(n+2, sort_nums)
  end
end

single_number(ar)
