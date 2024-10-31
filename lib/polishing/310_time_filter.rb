# Цель класса TimeFilter — фильтровать перечислимые объекты таким образом, чтобы через фильтр пропускались только времена между первым и вторым аргументами.
# Класс, который можно использовать как блок должен включать метод to_proc, это позволяет передать блок в filter! и partition, а также в такие методы, как reject.
class TimeFilter
  attr_reader :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def to_proc
    # вызов методов start и finish для self и установив их в качестве локальных переменных, сократил количество вызовов attr_reader вдвое.
    start = self.start
    finish = self.finish

    # улучшили обработку аргументов, которые могут передаватья вариативно
    if start && finish
      proc{|value| value >= start && value <= finish}
    elsif start
      proc{|value| value >= start}
    elsif finish
      proc{|value| value <= finish}
    else
      proc{|value| true}
    end
  end
end

array_of_times = [
  Time.local(2020, 9, 15, 12, 0),  # 15 сентября 2020
  Time.local(2020, 10, 1, 9, 30),  # 1 октября 2020
  Time.local(2020, 10, 15, 16, 45),  # 15 октября 2020
  Time.local(2020, 11, 5, 14, 0),  # 5 ноября 2020
  Time.local(2020, 11, 10, 10, 15), # 10 ноября 2020
  Time.local(2020, 12, 1, 8, 30)    # 1 декабря 2020
]

# Экземпляр класса TimeFilter можно передать как блок при фильтрации.
time_filter = TimeFilter.new(Time.local(2020, 10), Time.local(2020, 11))
p array_of_times.filter!(&time_filter)

#  Клас TimeFilter мoжет исключить любой из концов, чтобы фильтровать времена только в одном направлении. 
after_now = TimeFilter.new(Time.now, nil)

# Класс TimeFilter может отделить времена, которые находятся в фильтре, от времен, которые находятся вне фильтра, с помощью Enumerable#partition:
in_future, in_past = array_of_times.partition(&after_now)
p in_future
p in_past
