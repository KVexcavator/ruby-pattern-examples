# http://rubyblog.pro/2017/11/chain-of-responsibility-ruby
# Назначение шаблона цепочки ответственности состоит в том, чтобы отделить отправителя запроса от его получателя, предоставив более чем одному объекту возможность обработать запрос.

# есть какаято трансакция
class Transaction
  attr_reader :amount, :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end
end

# интерфейс базового обработчика
class BaseHandler
  attr_reader :successor

  def initialize(successor = nil)
    @successor = successor
  end

  def call(transaction)
    # если не может обработать, передает дальше по цепочке
    return successor.call(transaction) unless can_handle?(transaction)
    handle(transaction)
  end

  def handle(_transaction)
    raise NotImplementedError, 'Each handler should respond to handle and can_handle? methods'
  end
end

# есть обработчики, наледуемые от базы
class StripeHandler < BaseHandler
  private

  def handle(transaction)
    puts "handling the transaction with Stripe payment provider"
  end


  def can_handle?(transaction)
    transaction.amount < 100 && transaction.currency == 'USD'
  end
end

class BraintreeHandler < BaseHandler
  private

  def handle(transaction)
    puts "handling the transaction with Braintree payment provider"
  end

  def can_handle?(transaction)
    transaction.amount >= 100
  end
end

# создаем транзакцию и цепочку
transaction = Transaction.new(100, 'USD')
chain = StripeHandler.new(BraintreeHandler.new)
chain.call(transaction)
# => handling transaction with Braintree payment provider
