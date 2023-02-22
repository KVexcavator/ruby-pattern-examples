# Возврат дубликатов с исползованием списков
def return_duplicates(list)
  duplicates = []
  set = Set.new()
  list.each do |item|
    l1 = set.length
    set.add(item)
    l2 = set.length
    if l1 == l2
      duplicates << item
    end
  end
  duplicates
end

p list = ["Susan Adams", "Kwame Goodall", "Jill Hampton", "Susan Adams"]
p return_duplicates(list)
