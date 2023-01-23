# Проблема купли-продажи акций
# В заданном массиве, в котором n-й элемент — цена акции в n-й день. Вас просят купить один раз и продать один раз, в какой день вы будете покупать и в какой день вы будете продавать, чтобы получить максимальную прибыль.
# Или же
# В данном массиве чисел вам нужно максимизировать разницу между двумя числами, чтобы вы могли вычесть число, которое появляется перед ним, из числа, которое появляется после него.
stocks = [111, 110, 120, 115, 133, 117, 119]

# Решение состоит в том, чтобы отслеживать наименьшее значение, наблюдаемое до сих пор с самого начала. В каждой точке мы можем найти разницу и отследить максимальную прибыль. Это линейное решение, сложность алгоритма составляет O(n) раз.

def max_profit(stocks)
  size = stocks.size
  buy = 0
  sell = 0
  cur_min = 0
  cur_profit = 0
  max_profit = 0
  i = 0
  while i < size
    if stocks[i] < stocks[cur_min]
      cur_min = i
    end
    cur_profit = stocks[i]-stocks[cur_min]
    if cur_profit > max_profit
      buy = cur_min
      sell = i
      max_profit = cur_profit
    end
    i += 1
  end
  puts "Purchase day is #{buy} , at price #{stocks[buy]}"
  puts "Sell day is #{sell} , at price #{stocks[sell]}"
  return p ( stocks[sell] - stocks[buy])
end

max_profit(stocks)
