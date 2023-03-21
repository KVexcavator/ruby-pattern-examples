# подсчитать символы в строке

def count(str)
  dict = {}
  str.each_char do |char|
    if dict.include? char
      dict[char] += 1
    else
      dict[char] = 1
    end
  end
  dict
end

p count("amdmsjjfjklsdjjfjkdlkjjjgj")
