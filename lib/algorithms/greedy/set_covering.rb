# Задача о покрытии множества
# Вы открываете собственную авторскую програм­му на радио и хотите, чтобы вас слушали во всех 50 штатах. Нужно решить, на каких радиостанци­ях должна транслироваться ваша передача. Количество станций не­ обходимо свести к минимуму.

# Список штатов(Set)
states_needed = Set.new(["mt" ,"wa", "or","id" ,"nv" ,"ut" ,"са" ,"az"])
# Список радиостанций
stations = {}
stations["kone"] = Set.new(["id", "nv", "ut"])
stations["ktwo"] = Set.new(["wa", "id", "mt"])
stations["kthree"] = Set.new(["or", "nv", "са"])
stations["kfour"] = Set.new(["nv", "ut"])
stations["kfive"] = Set.new(["ca", "az"])
# итоговой набор станций
final_stations = Set.new()

until states_needed.empty?
  # вначале выбираем лучшую станцию
  best_station = nil
  states_covered = Set.new() # штаты, обслуживаемые этой стан­цией
  stations.each do |station, states_for_station |
    # пересечение, элемент входит в оба сета
    covered = states_needed & states_for_station
    if covered.length > states_covered.length
      best_station = station
      states_covered = covered
      final_stations << best_station
      states_needed = states_needed - states_covered
    end
  end
end

p final_stations