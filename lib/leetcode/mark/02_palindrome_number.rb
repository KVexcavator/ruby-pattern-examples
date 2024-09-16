# @param {Integer} x
# @return {Boolean}
def is_palindrome(x)
  a = x.to_s.split('')
  a == a.reverse
end
