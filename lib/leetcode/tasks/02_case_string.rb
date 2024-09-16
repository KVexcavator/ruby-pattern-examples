#coding: utf-8
# Имеется строка набранная в разном регистре, например: «ВотТакаяСтрока»
# требуется получить в результате строку где буквы меняют регистр, то есть:
# «вОТтАКАЯсТРОКА»

old_str = "ВотТакаяСтрока"
new_str = ""

old_str.each_char do |char|
  if char.match?(/[А-Я]/)
    new_str += char.downcase!
  else
    new_str += char.upcase!
  end
end 
puts old_str
puts new_str

# в Ruby есть экзотический метод 
puts " БаРбамБиа кеРГудУ".swapcase


