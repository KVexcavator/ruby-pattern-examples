# Struct.new не возвращает экземпляр Struct, он возвращает подкласс Struct
p Struct.new(:a, :b).class # => Class
# если вы предоставите строку, а не символ в качестве первого аргумента, Struct автоматически создаст класс, используя это имя
p Struct.new(:a, :b).new(1, 2).class # => Struct::A
# мы не можем наследоваться от Struct

p Process.clock_gettime(Process::CLOCK_MONOTONIC)
p Time.now