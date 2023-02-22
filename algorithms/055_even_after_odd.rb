# данно массив целых чилсел, вернуть в котором четные после нечетных
def even_after_odd(list)
  odds = []
  evens = []
  list.each do |item|
    if item.odd?
      odds << item
    else
      evens << item
    end
  end
  odds + evens
end

list = [1, 28, 43, 70, 2, 9, 62, 31, 4, 15]
p even_after_odd(list)
