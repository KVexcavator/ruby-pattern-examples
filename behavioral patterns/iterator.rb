# https://gist.github.com/dljerome/e45973f9541a7f461fd5a67523e45c4e#file-iterator_pattern-rb
#Итератор — это поведенческий паттерн проектирования, который даёт возможность последовательно обходить элементы составных объектов, не раскрывая их внутреннего представления.

# Внешний итератор выполняет итерацию по агрегатному объекту из-за пределов этого агрегатного объекта. Следовательно, массив, который предназначен для обхода ExternalIterator, передается при построении, а не определяется в самом массиве.

class ExternalIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def first
    @array[0]
  end

  def next
    value = @array[@index]
    @index += 1
    value
  end

  def is_done?
    @index == @array.length - 1
  end

  def current_item
    @array[@index]
  end

  def has_next?
    @index < @array.length
  end

  def previous
    value = @array[@index]
    @index -= 1
    value
  end

  def has_previous?
    @index > 0
  end

  def rewind
    @index = 0
  end
end

fruits = %w(orange apple mango)
array_iterator = ExternalIterator.new(fruits)

while array_iterator.has_next?
  puts array_iterator.next_item
end

# Внутренний итератор. Метод each в Ruby считается «внутренним», потому что сам массив (агрегат) определяет и контролирует метод итерации относительно самого себя.

fruits.each do |fruit|
  puts fruit
end
