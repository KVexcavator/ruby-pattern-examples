# без фабричного метода
# if type == :email
#   EmailNotification.new.send_message
# elsif type == :sms
#   SmsNotification.new.send_message
# else
#   PushNotification.new.send_message
# end

# с фабричным методом
# Метод camelize есть только в ActiveSupport (часть Rails).
# В чистом Ruby он отсутствует.

class NotificationSender
  def self.build(type)
    
    # "email".camelize  => "Email"
    klass_name = "Notifications::#{type.to_s.camelize}"

    if Object.const_defined(klass_name)
      # constantize загружает класс по имени
      # "Notifications::Email".constantize => Notifications::Email (класс)
      klass_name.constantize.new
    else
      raise UnknownNotificationTypeError, "Unknown type: #{type}"
    end
  end
end

class UnknownNotificationTypeError < StandardError; end

class Notifications
  class Email
    def send_message
      "Sending Email..."
    end
  end

  class Sms
    def send_message
      "Sending Sms..."
    end
  end
# Метод camelize есть только в ActiveSupport (часть Rails).
    # В чистом Ruby он отсутствует.
  class Push
    def send_message
      "Sending Push Notification..."
    end
  end
end

sender = NotificationSender.build(:email)
sender.send_message