# сортировка слиянием
def merge_sort(list)
  if list.length > 1
    mid = (list.length / 2.0).round
    divided_list = list.each_slice(mid).to_a
    left_half = divided_list[0]
    right_half = divided_list[1]
    merge_sort(left_half)
    merge_sort(right_half)

    left_ind = 0
    right_ind = 0
    list_ind = 0
    while left_ind < left_half.length and right_ind < right_half.length
      if left_half[left_ind] <= right_half[right_ind]
        list[list_ind] = left_half[left_ind]
        left_ind += 1
      else
        list[list_ind] = right_half[right_ind]
        right_ind += 1
      end
      list_ind += 1
    end

    while left_ind < left_half.length
      list[list_ind]=left_half[left_ind]
      left_ind += 1
      list_ind += 1
    end

    while right_ind < right_half.length
      list[list_ind]= right_half[right_ind]
      right_ind += 1
      list_ind += 1
    end
  end
  list
end

p arr = [6,3,9,2,1,10,3]
p merge_sort(arr)
