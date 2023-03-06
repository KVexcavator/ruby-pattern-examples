# стек для отслеживания наименьшего элемента
# Ключом к решению данной задачи является использование двух стеков: главного и минимального. Главный стек будет отслеживать все операции проталкивания и выталкивания, а минимальный стек будет отслеживать наименьший элемент в стеке.

class MinStack
  def initialize()
    $main = []
    $min = []
  end

  def main
    $main
  end

  def min
    $min
  end

  def push(num)
    if $main.size == 0
      $min.push(num)
    elsif num <= $min[-1]
      $min.push(num)
    else
      $min.push($min[-1])
    end
    $main.push(num)
  end

  def pop
    $min.pop
    $main.pop
  end

  def get_min
    $min[-1]
  end
end

ms = MinStack.new()
p ms.push(10)
p ms.main
p ms.min
p "========="
p ms.push(15)
p ms.main
p ms.min
p "========="
p ms.get_min
p "========="
p ms.pop
p ms.pop
p ms.main
p ms.min
p "========="
