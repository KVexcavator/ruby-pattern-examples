# у нас есть доска судоки 9x9 клеток содержит 9 квадратов 3x3 внутри, нужно вычислить придерживается ли текущее состяние правил игры
# надо проверить соответствует состояние правилам(есть ли нарушения!)
# Output: true или false
# правило1: каждая вертикаль и горизонталь может быть заполнена уникалными цифрамиот 1-9 или быть пустой(0)
# правило2: каждый квадрат 3х3 может содержать уникальные цифры 1-9, или пустовать(0)

def verify_sudoku_board(board)
  # массив из 9 элементов, где каждый элемент — это новое пустое множество (Set.new)
  # [#<Set: {}>, #<Set: {}>, #<Set: {}>, #<Set: {}>, #<Set: {}>, #<Set: {}>, #<Set: {}>, #<Set: {}>, #<Set: {}>]
  row_sets = Array.new(9) { Set.new }
  column_sets = Array.new(9) { Set.new }
  # массив трех массивов с тремя пустыми сетами
  # [[#<Set: {}>, #<Set: {}>, #<Set: {}>], [#<Set: {}>, #<Set: {}>, #<Set: {}>], [#<Set: {}>, #<Set: {}>, #<Set: {}>]]
  subgrid_sets = Array.new(3) { Array.new(3) { Set.new } }
  (1...9).each do |r|
    (1...9).each do |c|
      num = board[r][c]
      if num == 0
        next
      end
      if row_sets[r].include?(num)
        puts "FALSE"
        return false
      end
      if column_sets[c].include?(num)
        puts "FALSE"
        return false
      end
      # цлочисленное деление r / 3 или r.div(3)
      if subgrid_sets[r.div(3)][c.div(3)].include?(num)
        puts "FALSE"
        return false
      end
      row_sets[r] << num
      column_sets[c] << num
      subgrid_sets[r.div(3)][c.div(3)] << num
    end
  end
  puts "TRUE"
  true
end

# сложность о эн в квадрате

board = [
  [3,0,6,0,5,8,4,0,0],
  [5,2,0,0,0,0,0,0,0],
  [0,8,7,5,0,0,3,2,0],
  [1,0,2,5,0,0,3,2,0],
  [9,0,0,8,6,3,0,0,5],
  [0,5,0,0,9,0,6,0,0],
  [0,3,0,0,0,8,2,5,0],
  [0,1,0,0,0,0,0,7,4],
  [0,0,5,2,0,6,0,0,0]
]

verify_sudoku_board(board)