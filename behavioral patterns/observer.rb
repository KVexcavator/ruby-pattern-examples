# https://medium.com/@nakshtra17/ruby-design-pattern-observer-method-eb7cb2a8d382
# Наблюдатель — это поведенческий паттерн проектирования, который создаёт механизм подписки, позволяющий одним объектам следить и реагировать на события, происходящие в других объектах.

# здесь пример нативной реализации
class Employee
  attr_reader :name, :title
  attr_reader :salary

  def initialize( name, title, salary, payroll)
    @name = name
    @title = title
    @salary = salary
    @payroll = payroll
  end

  def salary=(new_salary)
    @salary = new_salary
    @payroll.update(self)
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end

end

# подписчики должны иметь одинаковый медоды для вызова наблюдателем(в примере update)
fred = Employee.new('Fred', 'Crane Operator', 30000.0)
payroll = Payroll.new
fred.add_observer(payroll)
tax_man = TaxMan.new
fred.add_observer(tax_man)
fred.salary = 35000.0

# в Ruby есть специальный модуль Observable https://ruby-doc.org/stdlib-2.5.3/libdoc/observer/rdoc/Observable.html

require 'observer'
class Employee
  include Observable
  attr_reader :name, :title
  attr_reader :salary
  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
  end
  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end
end
