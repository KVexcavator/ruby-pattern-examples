# https://medium.com/@nakshtra17/ruby-design-pattern-composite-method-52406f8dd0c5
# Компоновщик — это структурный паттерн проектирования, который позволяет сгруппировать объекты в древовидную структуру, а затем работать с ними так, если бы это был единичный объект.

# абстрактная задача
class Task
  attr_accessor :name, :parent
  def initialize(name)
    @name = name
    @parent = nil
  end

  def get_time_required
    0.0
  end
end

# от неё можно наследовать много конкретных, например
class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end
  def get_time_required
    1.0
  end
end

# абстрактный контейнер для слохных задачь
class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end
  def add_sub_task(task)
    @sub_tasks << task
    task.parent = self
  end
  def remove_sub_task(task)
    @sub_tasks.delete(task)
    task.parent = nil
  end

  def get_time_required
    @sub_tasks.inject(0.0) {|time, task| time += task.get_time_required}
  end
end

# котейнеры для конкретных составных задач

class MakeBatterTask < CompositeTask
  def initialize
    super('Make batter')
    add_sub_task(AddDryIngredientsTask.new)
    add_sub_task(AddLiquidsTask.new)
    add_sub_task(MixTask.new)
  end
end

#  или ещё
class MakeCakeTask < CompositeTask
  def initialize
    super('Make cake')
    add_sub_task(MakeBatterTask.new)
    add_sub_task(FillPanTask.new)
    add_sub_task(BakeTask.new)
    add_sub_task(FrostTask.new)
    add_sub_task(LickSpoonTask.new)
  end
end
