### Form Object — это объект, который берёт на себя валидацию и обработку формы, чтобы не засорять модели. Это особенно полезно, когда:  
# - Форма не соответствует напрямую ни одной модели  
# - Форма работает сразу с несколькими моделями  
# - Нужно повторно использовать логику валидации  

## Структура проекта  
# обычно кладут в app/forms/ или app/services/forms/:

```
app/
 ├── controllers/
 ├── models/
 ├── forms/                # Здесь храним Form Objects
 │   ├── base_form.rb      # (необязательно) базовый класс
 │   ├── user_registration_form.rb  # Пример формы
```
## Простой пример Form Object 
# Допустим, у нас форма регистрации пользователя, где надо:  
# - Создать пользователя  
# - Проверить, что пароль совпадает с подтверждением  
# - Отправить email  

# app/forms/user_registration_form.rb 
class UserRegistrationForm
  include ActiveModel::Model   # Даст валидации, ошибки и другие возможности

  attr_accessor :email, :password, :password_confirmation, :nickname

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, confirmation: true
  validates :nickname, presence: true, uniqueness: { case_sensitive: false }

  def save
    return false unless valid?

    user = User.create(email: email, password: password, nickname: nickname)
    UserMailer.welcome_email(user).deliver_later
    true
  end
end
# - ActiveModel::Model — даёт valid?, errors и другие фичи модели.  
# - attr_accessor — задаёт атрибуты, как в обычной модели.  
# - validates — стандартные рельсовые валидации.  
# - save — выполняет логику создания.  

# Контроллер с использованием Form Object
# app/controllers/registrations_controller.rb 
class RegistrationsController < ApplicationController
  def create
    form = UserRegistrationForm.new(user_params)

    if form.save
      render json: { message: "User registered successfully" }, status: :created
    else
      render json: { errors: form.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname)
  end
end

## Дополнительные трюки и улучшения 

# 1. Базовый класс для форм 
# app/forms/base_form.rb
class BaseForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  def save
    return false unless valid?
    persist
  end

  private

  def persist
    raise NotImplementedError
  end
end
# Теперь формы можно наследовать от BaseForm:  
class UserRegistrationForm < BaseForm
  attribute :email, :string
  attribute :password, :string
  attribute :password_confirmation, :string
  attribute :nickname, :string

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, confirmation: true
  validates :nickname, presence: true, uniqueness: { case_sensitive: false }

  private

  def persist
    user = User.create(email: email, password: password, nickname: nickname)
    UserMailer.welcome_email(user).deliver_later
  end
end
# Теперь save вызывается у всех форм одинаково!

#2. Подключение ActiveModel::Attributes
# Если Rails 5.2+, можно использовать ActiveModel::Attributes:  
class UserRegistrationForm < BaseForm
  attribute :email, :string
  attribute :password, :string
  attribute :password_confirmation, :string
  attribute :nickname, :string
end
# Это даёт поддержку типов integer, datetime, boolean и т.д.  

# 3. Автоматическая работа с Strong Parameters 
# Можно добавить в BaseForm поддержку strong_parameters:  
class BaseForm
  include ActiveModel::Model

  def initialize(params = {})
    super(params.to_unsafe_h) if params.respond_to?(:to_unsafe_h)
  end
end
# Теперь можно писать:  
form = UserRegistrationForm.new(params[:user])
