# Перед вами замок с 4 круглыми колесами. Каждое колесо имеет 10 слотов: «0», «1», «2», «3», «4», «5», «6», «7», «8», «9». Колеса могут свободно вращаться и вращаться: например, мы можем превратить «9» в «0» или «0» в «9». Каждый ход состоит из поворота одного колеса на один слот.
# Блокировка изначально начинается с «0000», строки, представляющей состояние 4 колес.
# Вам дается список тупиковых тупиков, а это означает, что если на замке отобразится какой-либо из этих кодов, колеса замка перестанут вращаться, и вы не сможете его открыть.
# Учитывая цель, представляющую значение колес, которые откроют замок, верните минимальное общее количество оборотов, необходимое для открытия замка, или -1, если это невозможно.
# Input: deadends = ["0201","0101","0102","1212","2002"],  target = "0202"
# Output: 6

def open_lock(deadends, target)
  return -1 if deadends.include? "0000"

  # combinations("0000") => ["1000", "9000", "0100", "0900", "0010", "0090", "0001", "0009"]
  def combinations(comb)
    total = []
    4.times do |i|
      digit = ((comb[i].to_i + 1) % 10).to_s
      total << (comb[0...i] + digit + comb[(i + 1)..4])
      digit = ((comb[i].to_i - 1 +10) % 10).to_s
      total << (comb[0...i] + digit + comb[(i + 1)..4])
    end
    total
  end

  queue = [["0000", 0]] # [comb, turns]
  visit = Set.new(deadends)

  while !queue.empty?
    comb, turns = queue.shift
    return turns if comb == target

    combinations(comb).each do |comb|
      if !visit.include?(comb)
        visit << comb
        queue << [comb, turns + 1]
      end
    end
  end
  -1
end


# Output: 6
deadends = ["0201","0101","0102","1212","2002"]
target = "0202"
p open_lock(deadends, target)

# Output: 1
deadends = ["8888"]
target = "0009"
p open_lock(deadends, target)

# Output: -1
deadends = ["8887","8889","8878","8898","8788","8988","7888","9888"]
target = "8888"
p open_lock(deadends, target)
