# сдвинуть нули в конец
def move_zeros(list)
  counter = 0
  list.each_with_index do |element, index|
    if element != 0
      list[counter] = element
      if counter != index
        list[index] = 0
      end
      counter +=1
    end
  end
  list
end

p list = [8, 0, 3, 0, 12]
p move_zeros(list)
