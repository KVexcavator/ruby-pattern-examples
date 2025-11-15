# Алгоритм Дейкстры
# ищет кратчайший путь с учетом веса каждого ребра
# не найдет путь если у ребра отрицательная стоимость, даже если он есть
# 1. Найти узел с наименьшей стоимостью
# Проверить, существует ли более дешевый путь к соседям этого узла, и если существует, обновить их стоимости.
# 3. Повторять, пока это не будет сделано для всех узлов графа.
# 4. Вычислить итоговый путь

graph = {
  start: {a:6, b: 2}, 
  a: {fin: 1}, 
  b: {a: 3, fin: 5}, 
  fin: {}
}
infinity = Float::INFINITY
costs = {
  a: 6,
  b: 2,
  fin: infinity
}
parents = {
  a: :start,
  b: :start,
  fin: nil
}
# для отслеживания всех уже обработанных уз­лов
processed = []

def find_lowest_cost_node(costs, processed)
  lowest_cost = Float::INFINITY
  lowest_cost_node = nil
  # перебрать все узлы
  costs.keys.each do |node|
    cost = costs[node]
    # если это узел с наименьшей стоисомтью из уже виденных
    # и он ещё не был обработан
    if (cost < lowest_cost) && !processed.include?(node)
      # он назначается новым узлом с наименьшей стоимостью
      lowest_cost = cost
      lowest_cost_node = node
    end
  end
  lowest_cost_node
end

# найти узел с наименьшей стоимостью среди необработанных
node = find_lowest_cost_node(costs, processed)
# Если обработаны все узлы, цикл while завершен
until node.nil?
  cost = costs[node]
  neighbors = graph[node]
  # пуребрать всех соседей текущего узла
  neighbors.keys.each do |n|    
    new_cost = cost + neighbors[n]
    # если к соседу можно добраться через текущий узел
    if costs[n] > new_cost
      # обновить стоимость этого узла
      costs[n] = new_cost
      # этот узел становится новым родителем для соведа
      parents[n] = node
    end
  end
  # узел помечается как обработаный
  processed << node
  # найти следующий узел для обработки и повторить цикл
  node = find_lowest_cost_node(costs, processed)
end

# Восстановление пути
def reconstruct_path(parents, start, finish)
  path = []
  node = finish
  while node
    path.unshift(node)
    node = parents[node]
  end
  path.unshift(start) unless path.first == start
  path
end

# Вызов функции для построения пути
shortest_path = reconstruct_path(parents, :start, :fin)

# Вывод результатов
puts "Кратчайший путь: #{shortest_path.join(' → ')}"
puts "Минимальная стоимость до финальной точки: #{costs[:fin]}"