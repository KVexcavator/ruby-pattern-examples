
def reverse_string(str)
  stack = []
  res = ""
  str.each_char do |c|
    stack.push(c)
  end
  str.each_char do
    res << stack.pop
  end
  res
end

p reverse_string("abcdf")
