# Напишите программу, которая выводит на экран числа от 1 до 100. 
# При этом вместо чисел, кратных 3, программа должна выводить слово «Hi», 
# а вместо чисел, кратных 5— слово «By». 
# Если число кратно и 3, и 5, то программа должна выводить слово «HiBy».

digits = 1..100
digits.each do |v|
  if (v % 3 == 0) and (v % 5 == 0)
    puts "HiBy"
  elsif v % 3 == 0
    puts "Hi"
  elsif v % 5 == 0
    puts "By"
  else
    puts v
  end
end