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

["abcabcbb", "bbbbb", "pwwkew", "", "cbb", "abcabcbb", "bcb", "bbc", "asjrgapa"].each do |str|
  puts "Res: #{length_of_longest_substring(str)} in string-#{str}"
end

def generate_code(number)
  charset = Array('A'..'Z') + Array('a'..'z')
  Array.new(number) { charset.sample }.join
end
p string = generate_code(40)
p length_of_longest_substring(string)
