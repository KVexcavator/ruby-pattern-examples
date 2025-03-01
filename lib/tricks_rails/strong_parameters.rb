### трюк с strong_parameters
# Этот приём позволяет автоматически конвертировать ActionController::Parameters в обычный Hash.
# В Rails params внутри контроллера — это объект ActionController::Parameters. Это не обычный Hash, а защищённый объект, который запрещает доступ к данным без явного разрешения.  
# если передать ActionController::Parameters в ActiveModel::Model, он не поймёт, что с ним делать. Вот почему обычно используют .permit:  
params.require(:user).permit(:email, :password, :nickname)

# Как работает этот трюк 
class BaseForm
  include ActiveModel::Model

  def initialize(params = {})
    super(params.to_unsafe_h) if params.respond_to?(:to_unsafe_h)
  end
end
# 1. params.respond_to?(:to_unsafe_h)
# Проверяем, поддерживает ли объект метод to_unsafe_h 
# - ActionController::Parameters` поддерживает этот метод
# - Обычный Hash не поддерживает, значит super(params) вызовется как есть

# 2. params.to_unsafe_h принудительно конвертирует ActionController::Parameters в `Hash`, снимая ограничения безопасности не требуя permit 

# Без этого трюка в контроллере нужно вручную вызывать .permit:  
form = UserRegistrationForm.new(params.require(:user).permit(:email, :password, :nickname))
# С этим трюком  
form = UserRegistrationForm.new(params[:user])---

# Осторожно: .to_unsafe_h убирает защиту strong_parameters.
# Если нужно оставить защиту, лучше писать так: 
def initialize(params = {})
  permitted_params = params.is_a?(ActionController::Parameters) ? params.permit!.to_h : params
  super(permitted_params)
end
# permit! разрешает все атрибуты (можно заменить на permit(:email, :password)).  
# to_h делает обычный Hash

## можно вынести логику обработки params в конфигурацию, чтобы каждый Form Object автоматически преобразовывал ActionController::Parameters в Hash.  

# Вариант 1: Monkey-patch для ActiveModel::Model  
# Можно изменить поведение ActiveModel::Model, чтобы он сам обрабатывал params:  
# config/initializers/form_object.rb
module StrongParamsHandler
  def initialize(params = {})
    safe_params = params.respond_to?(:to_unsafe_h) ? params.to_unsafe_h : params
    super(safe_params)
  end
end
ActiveModel::Model.prepend(StrongParamsHandler)
# Теперь любой класс, включающий ActiveModel::Model, автоматически обрабатывает параметры
class UserRegistrationForm
  include ActiveModel::Model
  attr_accessor :email, :password
end
params = ActionController::Parameters.new(user: { email: "test@example.com", password: "123456" })
form = UserRegistrationForm.new(params[:user]) # Автоматически работает!
# Больше не нужно вручную обрабатывать params в Form Objects 

# Вариант 2: Базовый класс ApplicationForm 
# app/forms/application_form.rb 
class ApplicationForm
  include ActiveModel::Model

  def initialize(params = {})
    safe_params = params.is_a?(ActionController::Parameters) ? params.to_unsafe_h : params
    super(safe_params)
  end
end
