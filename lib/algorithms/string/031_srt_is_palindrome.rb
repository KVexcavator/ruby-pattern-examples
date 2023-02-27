# Палиндром — слово, которое читается одинаково слева направо и справа налево

def is_palindrome(str)
  return true if str.downcase == str.reverse.downcase
  false
end

p str = "blackswan"
p is_palindrome(str)
p "-------"
p str = "level"
p is_palindrome(str)
