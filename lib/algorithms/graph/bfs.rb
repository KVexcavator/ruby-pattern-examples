# Breadth-First Search
# поиск кратчайшего пути в графе(если есть)
# путь здесь считается кратчайшим потому что включает наименьшее количество ребер

graph = {}
graph["you"] = ["alice", "bob", "claire"]
graph["bob"] = ["anuj", "peggy"]
graph["alice"] = ["peggy"]
graph["claire"] = ["thom", "jonny"]
graph["anuj"] = []
graph["peggy"] = []
graph["thom"] = []
graph["jonny"] = []

def person_is_seller(name)
  name[-1] == 'm'
end

def search(name, graph)
  search_queue = []
  search_queue = search_queue.concat(graph[name])
  searched = []
  until search_queue.empty?
    person = search_queue.shift
    unless searched.include?(person)
      if person_is_seller(person)
        puts "#{person} is mango seller"
        return true
      else
        search_queue = search_queue.concat(graph[person])
        searched << person
      end
    end
  end
  puts "FALSE"
end

search("you", graph)