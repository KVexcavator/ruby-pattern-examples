# Have the function PalindromeSwapper(str) take the str parameter being passed and determine if a palindrome can be created by swapping two adjacent characters in the string. If it is possible to create a palindrome, then your program should return the palindrome, if not then return the string -1. The input string will only contain alphabetic characters. For example: if str is "rcaecar" then you can create a palindrome by swapping the second and third characters, so your program should return the string racecar which is the final palindromic string.
# Examples
# Input: "anna"
# Output: anna
# Input: "kyaak"
# Output: kayak


def PalindromeSwapper(str)

  str = str.downcase
  i = 0
    while i < (str.length-1)
      arr = str.split('')
      arr[i],arr[i+1] = arr[i+1],arr[i]
      str_acc = arr.join('')
      if str_acc == str_acc.reverse
        return str_acc
      else
        i += 1
      end
    end
  "-1"
end

 
puts PalindromeSwapper(STDIN.gets)
