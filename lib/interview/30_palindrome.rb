# дана строка, надо надо выяснить встречаются ли полиндромы после удения всех не буквенных символов. символы могут быть буквами и цифрами.все в нижнем регистре.
# Пример:
# input: s = "a dog! a panic in a pagoda."
# Output: True
# input: s = "abc123"
# Output: False
def is_palindrome_valid(str)
  left,right = 0, str.length - 1
  while left < right
    while (left < right) && str[left] !~ /[a-z0-9]/
      left = left + 1
    end
    while (left < right) && str[right] !~ /[a-z0-9]/
      right = right - 1
    end
    if str[left] != str[right]
      puts "False"
      return false
    end
    left = left + 1
    right = right - 1
  end
  
  puts "True"
  true
end

is_palindrome_valid("a dog! a panic in a pagoda.")
is_palindrome_valid("abc123")