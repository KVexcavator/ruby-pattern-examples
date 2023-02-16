# Прокси: Центральная предпосылка шаблона Proxy заключается в том, что всякий раз, когда вам нужно контролировать доступ к объекту, объект Proxy сделает свое дело. Находясь между вызывающей стороной (клиентом) и получателем (субъектом), класс прокси шаблона прокси может обеспечить защиту, скрыть сложность или задержать дорогостоящие действия.

# Класс 'BankAccount' будет 'Subject' этой конкретной демонстрации шаблона Proxy. Он будет проксироваться в каждом из следующих примеров.

class BankAccount
  def balance
    puts "check balance"
  end

  def deposit(amount)
    puts "deposit #{amount}"
  end

  def withdraw(amount)
    puts "withdraw #{amount}"
  end
end

# Класс RemoteBankAccountProxy будет действовать как локальный представитель удаленного объекта BankAccount. Он будет скрывать и управлять запросами и защитой информации по сети на удаленном сервере.
# С точки зрения локального клиента RemoteBankAccountProxy идентичен объекту BankAccount на удаленном сервере.

class RemoteBankAccountProxy
  def initialize
    @base_uri = "localhost:3000/bank_account"
  end

  def balance
    rest_service.get("/balance")
  end

  def deposit(amount)
    rest_service.post("/deposit", {amount: amount})
  end

  def withdraw(amount)
    rest_service.delete("/withdraw", {amount: amount})
  end

  private
  def rest_service
    @rest_client ||= RestClient.new(base_uri, :json)
  end

  attr_reader :rest_service
end

# Когда на этом прокси вызывается «баланс», «субъект лениво создается по запросу. Другими словами, если объект банковского счета еще не создан, он будет создан и установлен.

class VirtualBankAccountProxy

  def balance
    subject.balance
  end

  def deposit(amount)
    subject.deposit(amount)
  end

  def withdraw(amount)
    subject.withdraw(amount)
  end

  private

  def subject
    @subject ||= BankAccount.new
  end
end

# Класс 'ProtectionBankAccountProxy', являясь 'защитным прокси', отвечает за защиту предметного объекта 'BankAccount' от нежелательного доступа. Он действует как буфер безопасности для объекта «BankAccount», позволяя этому объекту заниматься поведением и обязанностями своего собственного домена, а не проблемами безопасности.

class ProtectionBankAccountProxy
  attr_reader :user_credentials
  def initialize(user_credentials)
    @subject = BankAccount.new
    @user_credentials = user_credentials
  end

  def balance
    check_permissions(:read)
    subject.balance
  end

  def deposit(amount)
    check_permissions(:write)
    subject.deposit(amount)
  end

  def withdraw(amount)
    check_permissions(:write)
    subject.withdraw(amount)
  end

  private

  def check_permissions(permission_type)
    unless CredentialValidator.validate(@user_credentials, permission_type)
      raise "Unauthorized #{permission_type} action from: #{@user_credentials}. Account action denied."
    end
  end
end
