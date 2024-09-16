#coding: utf-8
# Дана строка s и словарь dict, содержащий некие слова. Определите, можно ли
# строку s сегментировать в последовательность разделенных пробелом слов,
# содержащихся в словаре dict.
# Пример: дано, s = «двадесятка», dict = [«два», «десятка», «девятка»]. Программа
# должна вернуть true , потому что «двадесятка» могут быть сегментированы как «два
# десятка».

s1 = "  дв  аде сятка   "
dict1 = ["два", "десятка", "девятка"]
s2 = "alma"
dict2 = ["al", "m", "oo","l","alm","almaa","maa"]
s3 = "barbambia"
dict3 = ["ia", "bar", "bamb"]
s4 = ""
dict4 = ["ding", "dong"]

 
def search_segment (str, arr, flag=true)
  # блок подготовки строки
  if str.empty? && flag 
    return false
  end
  flag = false
  str = str.gsub(/\s+/,'') if str.match?(/\s+/)
  # если строка сегментируется по словарю, она станет пустой
  return true if str.empty?
  # каждый член словаря захватываем, как регвыражение
  re = Regexp.new(arr.first)
  if str.match?(re)
    arr.shift
    str.gsub!(re, " ").to_s
  end  
  # рекурсия
  begin 
    search_segment str, arr, flag
  rescue SystemStackError
    return false
  end 
end 

puts search_segment s1, dict1
puts "- - - - -"
puts search_segment s2, dict2
puts "- - - - -"
puts search_segment s3, dict3
puts "- - - - -"
puts search_segment s4, dict4
