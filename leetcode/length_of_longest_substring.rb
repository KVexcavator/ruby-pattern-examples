def length_of_longest_substring(s)
  return 0 if s.length == 0
  chars = s.chars
  longests = []
  subarr = []
  while chars.length > 0
    if not subarr.include?(chars.last)
      subarr << chars.pop
      longests << subarr.length
    else
      subarr.shift
    end
  end
  longests.max
end

p str = "abcabcbb"
p length_of_longest_substring(str)
p str = "bbbbb"
p length_of_longest_substring(str)
p str = "pwwkew"
p length_of_longest_substring(str)
p str = ""
p length_of_longest_substring(str)
p str = "cbb"
p length_of_longest_substring(str)
p str = "abcabcbb"
p length_of_longest_substring(str)
p str = "bcb"
p length_of_longest_substring(str)
p str = "bbc"
p length_of_longest_substring(str)
p str = "asjrgapa"
p length_of_longest_substring(str)
