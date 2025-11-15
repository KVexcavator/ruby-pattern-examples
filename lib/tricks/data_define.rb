# Используйте Data.define для объектов значений — просто и безопасно.
# Добавьте строгую проверку типа в конструктор.
# Создавайте экземпляры с правильными объектами, а не строками.
# Отлавливайте ошибки на ранней стадии, избегая неожиданных ошибок во время выполнения.

Currency = Data.define(:code, :name, :symbol, :decimal)
USD = Currency.new(code: "USD", name: "US dollar", symbol: "$", decimal: 2)
EUR = Currency.new(code: "EUR", name: "Euro", symbol: "€", decimal: 2)

Price = Data.define(:amount, :currency) do
  def initialize(amount:, currency:)
    amount => Integer
    currency => Currency
    super
  end
end

p pr = Price.new(amount: 10, currency: USD)
#<data Price amount=10, currency=#<data Currency code="USD", name="US dollar", symbol="$", decimal=2>>
p pr.currency.name
# "US dollar"
==================================================
Для использования этого подхода в Rails при работе с ценами товаров можно:  

# 1. Создать Value Object для цены, используя Data.define.  
# 2. Хранить цену в БД в виде целого числа (например, в центах).  
# 3. Обрабатывать валюту как отдельный атрибут (например, строку "USD").  
# 4. Добавить кастомный сериализатор для хранения и извлечения объекта Price в ActiveRecord.  


### Пример реализации в Rails  

# Создадим миграцию, где price_amount хранит цену в центах, а currency_code — код валюты:

class AddPriceToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :price_amount, :integer, null: false, default: 0
    add_column :products, :currency_code, :string, null: false, default: "USD"
  end
end

# Создадим Currency и Price, используя Data.define как Value Object:  

Currency = Data.define(:code, :name, :symbol, :decimal) do
  def self.find_by_code(code)
    CURRENCIES.find { |c| c.code == code } || raise "Unknown currency: #{code}"
  end
end

CURRENCIES = [
  Currency.new(code: "USD", name: "US dollar", symbol: "$", decimal: 2),
  Currency.new(code: "EUR", name: "Euro", symbol: "€", decimal: 2)
]

Price = Data.define(:amount, :currency) do
  def initialize(amount:, currency:)
    amount => Integer
    currency => Currency
    super
  end

  def to_s
    "#{currency.symbol}#{format("%.#{currency.decimal}f", amount / (10.0**currency.decimal))}"
  end
end

# Чтобы Rails мог автоматически преобразовывать атрибуты в объект Price, добавим кастомный сериализатор:

class PriceSerializer
  def self.dump(price)
    { "amount" => price.amount, "currency" => price.currency.code }.to_json
  end

  def self.load(json)
    data = JSON.parse(json) rescue nil
    return nil unless data

    currency = Currency.find_by_code(data["currency"])
    Price.new(amount: data["amount"], currency: currency)
  end
end

# Теперь добавим поддержку Price в модель Product:

class Product < ApplicationRecord
  serialize :price, PriceSerializer

  def price
    Price.new(amount: price_amount, currency: Currency.find_by_code(currency_code))
  end

  def price=(value)
    self.price_amount = value.amount
    self.currency_code = value.currency.code
  end
end

# Использование  

product = Product.create!(
  name: "Apple iPhone",
  price: Price.new(amount: 99900, currency: Currency.find_by_code("USD"))
)

puts product.price # $999.00
puts product.price.currency.name # "US dollar"

product.price = Price.new(amount: 109900, currency: Currency.find_by_code("EUR"))
product.save!

puts product.price # €1099.00
