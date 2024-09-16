# Необходмо разработать код на Ruby, получающий на вход количество дисков, исходную, целевую и список запрещенных комбинаций и выводящую последовательность комбинаций от начальной до конечной, минуя запрещенные, или выводящий сообщение, что решения нет. Если возможных последовательностей несколько - необходимо вывести любую из них(не обязательно наикратчайшую).

# Например, при входных данных:
# DISC_COUNT = 3
# from = [0, 0, 0]
# to = [1, 1, 1]
# exclude = [[0, 0, 1], [1, 0, 0]]
# пример решения:
# [0, 0, 0]
# [0, 1, 0]
# [1, 1, 0]
# [1, 1, 1]

def find_path(disc_count, from, to, exclude)
  # Используем очередь для BFS
  queue = [[from]]
  # Сет для хранения посещенных комбинаций
  visited = [from]

  until queue.empty?
    path = queue.shift
    current = path.last

    # Проверяем, достигли ли мы целевой комбинации
    return path if current == to

    # Генерируем возможные переходы
    puts "===="
    p next_steps = generate_next_steps(current, disc_count)

    next_steps.each do |next_step|
      # Проверяем, не является ли следующий шаг запрещенной или уже посещенной комбинацией
      next if exclude.include?(next_step) || visited.include?(next_step)

      # Добавляем новый путь в очередь и отмечаем как посещенный
      queue << (path + [next_step])
      visited << next_step
    end
  end

  # Если решения нет
  "Решения нет"
end

# Генерация всех возможных переходов на основе текущей позиции
def generate_next_steps(current, disc_count)
  next_steps = []

  disc_count.times do |i|
    # Копируем текущий массив
    next_step_up = current.dup
    next_step_down = current.dup

    # Пытаемся увеличить и уменьшить диск i, если возможно
    next_step_up[i] += 1 if next_step_up[i] < 1
    next_step_down[i] -= 1 if next_step_down[i] > 0

    # Добавляем новые возможные позиции
    next_steps << next_step_up unless next_step_up == current
    next_steps << next_step_down unless next_step_down == current
  end

  next_steps
end

# Входные данные
disc_count = 3
from = [0, 0, 0]
to = [1, 1, 1]
exclude = [[0, 0, 1], [1, 0, 0]]

# Поиск и вывод результата
result = find_path(disc_count, from, to, exclude)
puts result.is_a?(Array) ? result.map(&:inspect).join("\n") : result

# https://github.com/KVexcavator/ruby-pattern-examples/blob/main/tricks/lock.rb
