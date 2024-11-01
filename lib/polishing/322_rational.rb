# В Ruby числовое значение с десятичной дробью, например, `0.20r`, представляет собой **рациональное число**. Суффикс `r` указывает на то, что число создается как объект класса `Rational`. 
# Использование суффикса `r` позволяет работать с дробями точно, что полезно в вычислениях, где важна абсолютная точность, например, в финансовых операциях.

### Пример использования:

# Обычное дробное число
float_number = 0.20
puts float_number   # => 0.2 (объект Float)

# Рациональное число
rational_number = 0.20r
puts rational_number  # => (1/5) (объект Rational)

# Операции с рациональными числами:
rational_number = 0.20r
sum = rational_number + 0.3r
puts sum  # => (11/15)

# Преобразование в другие типы:
rational_number = 0.20r
puts rational_number.to_f  # => 0.2
puts rational_number.to_s  # => "1/5"


