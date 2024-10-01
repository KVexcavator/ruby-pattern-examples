# Использование инверсии через DI (Dependency Injection, DI)
# В Ruby можно реализовать это через передачу зависимостей в конструкторе.

class UserNotifier
  def initialize(notification_service)
    @notification_service = notification_service
  end

  def notify
    @notification_service.send_notification
  end
end

class EmailService
  def send_notification
    puts "Отправляем email через DI..."
  end
end

# Внедряем зависимость
email_service = EmailService.new
notifier = UserNotifier.new(email_service)
notifier.notify  # Выведет: Отправляем email через DI...
