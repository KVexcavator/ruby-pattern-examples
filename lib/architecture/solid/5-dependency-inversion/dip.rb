# Абстракция (интерфейс), которую использует UserNotifier. Таким образом,передаются различные сервисы без изменения самого класса.

# Интерфейс для сервиса уведомлений
class NotificationService
  def send_notification
    raise NotImplementedError, "Метод должен быть реализован"
  end
end

# Конкретная реализация для отправки email
class EmailService < NotificationService
  def send_notification
    puts "Отправляем email..."
  end
end

# Конкретная реализация для отправки SMS
class SMSService < NotificationService
  def send_notification
    puts "Отправляем SMS..."
  end
end

class UserNotifier
  def initialize(notification_service)
    @notification_service = notification_service
  end

  def notify
    @notification_service.send_notification
  end
end

# Используем EmailService
notifier = UserNotifier.new(EmailService.new)
notifier.notify   # Выведет: Отправляем email...

# Используем SMSService
notifier = UserNotifier.new(SMSService.new)
notifier.notify   # Выведет: Отправляем SMS...
