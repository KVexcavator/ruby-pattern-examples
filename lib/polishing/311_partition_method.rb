# В Ruby метод partition используется для разделения коллекции (например, массива) на две части на основе условия, заданного в блоке.

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

even, odd = numbers.partition { |num| num.even? }

puts "Четные: #{even}"  # Четные: [2, 4, 6, 8, 10]
puts "Нечетные: #{odd}"  # Нечетные: [1, 3, 5, 7, 9]

numbers = [-5, 10, -3, 8, -1, 4, -7, 0]

positive, negative = numbers.partition { |num| num > 0 }

puts "Положительные числа: #{positive}"  # Положительные числа: [10, 8, 4]
puts "Отрицательные числа: #{negative}"  # Отрицательные числа: [-5, -3, -1, -7]
