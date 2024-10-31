# Повышение производительности с помощью переменных экземпляра
# Класс Invoice принимает массив экземпляров LineItem. Каждый LineItem содержит информацию о приобретенном товаре, цену товара и количество приобретенных товаров. 
# Необходимо рассчитать общую сумму налога путем умножения налоговой ставки на сумму общей стоимости позиций.

LineItem = Struct.new(:name, :price, :quantity)

class Invoice
  def initialize(line_items, tax_rate)
    @line_items = line_items
    @tax_rate = tax_rate
  end

  def total_tax
    # если total_tax часто вызывается несколько раз за время жизни экземпляра Invoice, кэширование значения может значительно повысить производительность.экземпляра
    # @total_tax ||= @tax_rate * @line_items.sum do |item|
    #   item.price * item.quantity
    # end
    # оператор ||= пересчитывает выражение, если переменная экземпляра @total_tax равна false или nil. Чтобы обработать этот случай, вы должны использовать явную проверку defined? для переменной экземпляра:
    return @total_tax if defined?(@total_tax)
    @total_tax = @tax_rate * @line_items.sum do |item|
      item.price * item.quantity
    end
  end
end

line_items = [
  LineItem.new("Apple", 0.99, 10),   # Яблоки по цене $0.99 за штуку, 10 штук
  LineItem.new("Banana", 0.49, 6),   # Бананы по цене $0.49 за штуку, 6 штук
  LineItem.new("Orange", 1.29, 4),   # Апельсины по цене $1.29 за штуку, 4 штуки
  LineItem.new("Grapes", 2.99, 1)    # Виноград по цене $2.99 за упаковку, 1 упаковка
]

invoice = Invoice.new(line_items, 0.20)
p invoice.total_tax