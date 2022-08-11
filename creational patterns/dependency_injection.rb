# Внедрение зависимостей — это распространенный способ сделать код более гибким и тестируемым за счет удаления строгих зависимостей от других классов, модулей и других типов зависимостей.
# Зависимость — это абстракция, от которой зависит другая абстракция.

# Пример зависимости Author ot RevenueCalculator
class Author
  # ...
  def monthly_revenue
      RevenueCalculator.calculate_for(self, month_to_date)
  end
end

# Внедрение зависимостей — это практика кодирования, которая позволяет вам переместить зависимость из внутренностей класса в его инициализацию.
# Принцип инверсии зависимостей гласит, что ваши объекты не должны полагаться на другие конкретные объекты (конкреции), а должны опираться на абстракции более высокого уровня.(D из SOLID)

# Исправить на
class Author
  def initialize(revenue_calculator: RevenueCalculator)
    @revenue_calculator = revenue_calculator
  end
  # ...
  def monthly_revenue
    @revenue_calculator.calculate_for(self, month_to_date)
  end
end

# так даже лучьше
class Author
  # ...
  def monthly_revenue(revenue_calculator)
    revenue_calculator.calculate_for(self, month_to_date)
  end
end
