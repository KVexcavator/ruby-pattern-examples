# Нельзя добавлять переменные экземпляра к замороженным объектам. Решение в этом случае — иметь незамороженный хэш переменной экземпляра внутри замороженного объекта.

LineItem = Struct.new(:name, :price, :quantity)

class Invoice
  def initialize(line_items, tax_rate)
    @line_items = line_items.map do |item|
      item.dup.freeze
    end.freeze # гарантированно замораживаем
    @tax_rate = tax_rate
    @cache = {} # не замороженная переменная
    freeze
  end

  def total_tax
    return @cache[:total_tax] if @cache.key?(:total_tax)
    @cache[:total_tax] = @tax_rate *
      @line_items.sum do |item|
        item.price * item.quantity
      end
  end
end

line_items = [
  LineItem.new("Apple", 0.99r, 10),   # Яблоки по цене $0.99 за штуку, 10 штук
  LineItem.new("Banana", 0.49r, 6),   # Бананы по цене $0.49 за штуку, 6 штук
  LineItem.new("Orange", 1.29r, 4),   # Апельсины по цене $1.29 за штуку, 4 штуки
  LineItem.new("Grapes", 2.99r, 1)    # Виноград по цене $2.99 за упаковку, 1 упаковка
]

invoice = Invoice.new(line_items, 0.095r)
p invoice.total_tax.to_f
line_items.first.quantity = 100
p invoice.total_tax.to_f

# Метод freeze делает объект неизменяемым. Когда объект заморожен:

# Невозможно изменить его состояние: добавлять или изменять переменные экземпляра, вызывать методы, которые модифицируют его.
# Любая попытка изменения (например, присвоить новое значение переменной экземпляра или вызвать метод вроде << для массива) приведет к выбросу исключения FrozenError.
# Что не замораживается:
# Переменные экземпляра, такие как @cache, @line_items, и @tax_rate, можно изменять до вызова метода freeze.
# Вложенные объекты не замораживаются автоматически. Например, хэш @cache и массив @line_items остаются изменяемыми, даже если сам объект заморожен. Это важно, так как кэширование данных будет работать через изменяемый объект @cache.