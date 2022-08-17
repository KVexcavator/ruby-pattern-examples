# https://dev.to/lccezinha/design-patterns-in-ruby-template-method-pattern-5ih
# Шаблонный метод — это поведенческий паттерн проектирования, который определяет скелет алгоритма, перекладывая ответственность за некоторые его шаги на подклассы. Паттерн позволяет подклассам переопределять шаги алгоритма, не меняя его общей структуры.

# базовый класс желательно сделать закрытым
class Base
  def title
    raise 'Must implement'
  end

  def description
    raise 'Must implement'
  end

  def benefits
    raise 'Must implement'
  end

  def output
    output = <<-STRING
      Title: #{title}
      Description: #{description}
      Plan benefits: #{benefits}.
    STRING

    puts(output)
  end
end

# Каждый подкласс реализует свое собственное поведение для каждого метода, не беспокоясь о методе output

class BasicPlan < Base
  def title
    "I'm the basic plan"
  end

  def description
    "My description of basic plan"
  end

  def benefits
    ['It is free', 'Access to one account', 'Basic features'].join(', ')
  end
end


class PremiumPlan < Base
  def title
    "I'm the premium plan"
  end

  def description
    "My description of premium plan"
  end

  def benefits
    [
      'It will cost USD 10.00',
      'Access to ten accounts',
      'Premium features',
      'You will receive a gift on your birthday'
    ].join(', ')
  end
end
