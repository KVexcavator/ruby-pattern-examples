# stripe - полоса
# для каждого нуля в n x m матрице, заменить все цифры с столбцах и рядах пересекающихся с нулевым значением

input = [
  [ 1, 2, 3, 4, 5],
  [ 6, 0, 8, 9,10],
  [11,12,13,14,15],
  [16,17,18,19, 0]
]
output = [
  [ 1, 0, 3, 4, 0],
  [ 0, 0, 0, 0, 0],
  [11, 0,13,14, 0],
  [ 0, 0, 0, 0, 0]
]

# если создать два Set c индексами подмассивов, один для отслеживания рядов с нулями, второй для отслеживания колонок с нулями, можно вычислить ячейку с нулем за O(1)
# zero_rows = {1, 3}
# zero_cols = {1, 4}
# останется только пройтись по индексам для замены

def zero_striping_with_sets(matrix, mask)
  return unless matrix&.first
  m = matrix.length
  n = matrix.first.length
  zero_rows,zero_cols = Set.new, Set.new
  (0...m).each do |r|
    (0...n).each do |c|
      if matrix[r][c] == 0
        zero_rows << r
        zero_cols << c
      end
    end
  end
  (0...m).each do |r|
    (0...n).each do |c|
      if (zero_rows.include?(r) || zero_cols.include?(c))
        matrix[r][c] = 0
      end
    end
  end
  puts "equal" if matrix == mask
end
# временная сложность O(m-n)
# пространствення сложность O(m+n)
zero_striping_with_sets(input, output)
puts "==================="

# мы можем исползовять первую колонку для того чтобы понять, что ряд должен все заменить на нули
# также первый ряд, понять что в колонках надо все заменитьна нули
# когда перывые ряд и\или столбец содержат нули этоможет привести к путанице
# исползуем булевы флаги для помечания содержат ли первые нули

def zero_striping(matrix, mask)
  return unless matrix&.first
  m,n = matrix.length, matrix.first.length
  first_row_has_zero = false
  (0...n).each do |c|
    if matrix[0][c] == 0
      first_row_has_zero = true
      break
    end
  end
  first_col_has_zero = false
  (0...m).each do |r|
    if matrix[r][0] == 0
      first_col_has_zero = true
      break
    end
  end
  (1...m).each do |r|
    (1...n).each do |c|
      if matrix[r][c] == 0
        matrix[0][c] = 0
        matrix[r][0] = 0
      end
    end
  end
  (1...m).each do |r|
    (1...n).each do |c|
      if (matrix[0][c] == 0 || matrix[r][0] == 0)
        matrix[r][c] = 0
      end
    end
  end
  if first_row_has_zero
    (0...n).each do |c|
      matrix[0][c] = 0
    end
  end
  if first_col_has_zero
    (0...m).each do |r|
      matrix[r][0] = 0
    end
  end
  puts "equal" if matrix == mask
end
input = [
  [ 1, 2, 3, 0, 5],
  [ 6, 0, 8, 9,10],
  [11,12,13,14,15],
  [16,17,18,19, 0]
]
output = [
  [ 0, 0, 0, 0, 0],
  [ 0, 0, 0, 0, 0],
  [11, 0,13, 0, 0],
  [ 0, 0, 0, 0, 0]
]
# пространственная сложность O(1)
zero_striping(input, output)