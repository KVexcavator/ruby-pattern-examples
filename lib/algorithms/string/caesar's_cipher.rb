# Юлий Цезарь защищал свои личные послания шифром. Для начала он выбирал число, а затем каждую букву смещал на это число. Например, если он выбирал цифру 3, то строка abc превращалась в def. Когда смещение доходило до конца алфавита, шифровальщик возвращался к его началу. Скажем, если требовалось сместить букву z на два символа, она становилась b.
# Модульная арифметика — вид арифметики, когда отсчет начинается заново после достижения определенного значения
# Например определение времени по часам. В какое время прибудет самолет? 9 плюс 8 равно 17. Но на 12-часовом циферблате нет числа 17. Чтобы определить время прилета, вы складываете 9 и 8 (17) и вычисляете результат по модулю 12.
# 17 % 12
# Семнадцать делится на 12 один раз, остаток равен 5, а это значит, что рейс прибудет в 5 часов утра

def ceasar_cipher(str, key)
  uppercase = 'abcdefghijklmnopqrstuvwxyz'
  lowercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  encrypt = ''
  str.chars.each do |c|
    if uppercase.include?(c)
      new_index = (uppercase.index(c) + key) % 26
      encrypt << uppercase[new_index]
    elsif lowercase.include?(c)
      new_index = (lowercase.index(c) + key) % 26
      encrypt << lowercase[new_index]
    else
      encrypt += c
    end
  end
  encrypt
end

p str = "barbambia"
p key = 3
p ceasar_cipher(str, key)
