# Пример с неправильным поведением 
# Класс, который напрямую зависит от другого класса. Это нарушение принципа инверсии зависимостей
# Здесь UserNotifier зависит напрямую от конкретной реализации класса EmailService. Если мзаменить отправку email на SMS или другую систему, придется менять код в UserNotifier.

class EmailService
  def send_email
    puts "Отправляем email..."
  end
end

class UserNotifier
  def initialize
    @email_service = EmailService.new
  end

  def notify
    @email_service.send_email
  end
end

notifier = UserNotifier.new
notifier.notify
