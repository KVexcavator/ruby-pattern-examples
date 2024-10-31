# дана строка, найдите наиболшее число повторяющихся подрад симаолов
# ответ в виде хеша, например {"a" => 2, "b" => 1, "c" => 3}

def max_num_chars(str)
  raise "str is empty" if str.empty?
  hash_chars = Hash.new(0) # значение по умолчанию — 0
  str.each_char do |char|
    next if char == "\s" # удалить все пробельные символы
    hash_chars[char] = hash_chars[char].to_i + 1
  end
  hash_chars
end

string = "aaacccbdd DDDaab  .AA фффыыёёё"
p max_num_chars(string)
empty_string = ""
p max_num_chars(empty_string)
