# Инверсия зависимостей с использованием модулей
# Можно также использовать Ruby модули для создания более гибких архитектур, которые поддерживают инверсию зависимостей.

module NotificationService
  def send_notification
    raise NotImplementedError, "Метод должен быть реализован"
  end
end

class EmailService
  include NotificationService

  def send_notification
    puts "Отправляем email через модуль..."
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

notifier = UserNotifier.new(EmailService.new)
notifier.notify   # Выведет: Отправляем email через модуль...

