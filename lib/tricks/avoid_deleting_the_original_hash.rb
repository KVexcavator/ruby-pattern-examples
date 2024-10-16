puts "обычное удаление из хеша"
p basket = { fruits: ["apple", "grapes"], veggies: ["kale", "cabbage"] }
basket.delete(:veggies)
p basket

puts "если хотим избежать изменения оригинала"
p basket = { fruits: ["apple", "grapes"], veggies: ["kale", "cabbage"] }
newbasket = basket.dup.tap { |produce| produce.delete(:veggies) }
p basket
p newbasket
