## Service Object  это объект, который инкапсулирует бизнес-логику, чтобы не загромождать модели и контроллеры.
# он используется:
# - Когда операция слишком сложная для модели  
# - Если нужна переиспользуемая логика
# - Если код захламляет контроллер
# - В API-first приложениях  

## Правильная структура в Rails, хорошая практика — создать директорию app/services/:

```
app/
 ├── controllers/
 ├── models/
 ├── services/
 │   ├── base_service.rb  # (необязательно) базовый класс
 │   ├── user_services/
 │   │   ├── create_user_service.rb
 │   │   ├── delete_user_service.rb
 │   ├── order_services/
 │   │   ├── process_order_service.rb
```
# Можно разделять сервисы по логическим группам, user_services/, order_services/ ... 

## Простой пример Service Object
# Допустим, у нас есть создание пользователя с валидацией, отправкой email и логированием.  
# Контроллер (до использования сервиса)
class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      UserMailer.welcome_email(user).deliver_later
      Rails.logger.info "User created: #{user.email}"
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
# Рефакторинг: выносим логику в Service Object
# app/services/user_services/create_user_service.rb 
module UserServices
  class CreateUserService
    def initialize(user_params)
      @user_params = user_params
    end

    def call
      user = User.new(@user_params)
      return Failure.new(user.errors.full_messages) unless user.save

      UserMailer.welcome_email(user).deliver_later
      Rails.logger.info "User created: #{user.email}"

      Success.new(user)
    end

    private

    class Success
      attr_reader :data
      def initialize(data); @data = data; end
    end

    class Failure
      attr_reader :errors
      def initialize(errors); @errors = errors; end
    end
  end
end
# Контроллер после рефакторинга
class UsersController < ApplicationController
  def create
    result = UserServices::CreateUserService.new(user_params).call

    if result.is_a?(UserServices::CreateUserService::Success)
      render json: result.data, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end
end

## Дополнительные фишки
# 1. Создаём базовый класс для сервисов
# app/services/base_service.rb
class BaseService
  def self.call(*args)
    new(*args).call
  end
end
# Теперь сервисы можно вызывать так: 
result = UserServices::CreateUserService.call(user_params)

# 2. Поддержка нескольких шагов (dry-monads)
# Если в проекте используется dry-monads, можно сделать сервис через Success / Failure:
require 'dry/monads'

module UserServices
  class CreateUserService
    include Dry::Monads[:result]

    def initialize(user_params)
      @user_params = user_params
    end

    def call
      user = User.new(@user_params)
      return Failure(user.errors.full_messages) unless user.save

      UserMailer.welcome_email(user).deliver_later
      Rails.logger.info "User created: #{user.email}"

      Success(user)
    end
  end
end
# Теперь обработка в контроллере:  
result = UserServices::CreateUserService.new(user_params).call

case result
when Dry::Monads::Success
  render json: result.value!, status: :created
when Dry::Monads::Failure
  render json: { errors: result.failure }, status: :unprocessable_entity
end
