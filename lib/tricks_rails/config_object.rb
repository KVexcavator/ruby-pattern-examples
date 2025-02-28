# Паттерн "Конфигурационный объект" (Configuration Object) или "Чтение данных из YAML-файла" в Ruby on Rails.

# config/operating_system.yml

production:
  ubuntu:
    name: ubuntu
    version: 20.04 LTS

development:
  ubuntu:
    name: ubuntu
    version: 21.04 LTS

# app/models/operating_system.rb

class OperatingSystem
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :string
  attribute :name, :string
  attribute :version, :string

  class << self
    def all
      @all ||=
        Rails.application.config_for(:operating_system).map do |key, attrs|
          new(atts.merge(id: key.to_s))
        end
    end

    def find(key)
      all.find { |os| os.id == key.to_s}
    end
  end
end

# usage
OperatingSystem.find(:ubuntu) # => <OperatingSystem...
OperatingSystem.find(:mandriva) # => nil

# Конфигурация в YAML
# В файле config/operating_system.yml хранятся данные о поддерживаемых операционных системах для разных окружений (production, development).
# Rails предоставляет метод Rails.application.config_for(:operating_system), который загружает этот файл и возвращает его содержимое в виде хеша.

# Использование ActiveModel::Model
# Класс OperatingSystem не является полноценной моделью ActiveRecord (он не связан с БД), но использует ActiveModel::Model и ActiveModel::Attributes, чтобы добавить поведение модели (валидаторы, атрибуты и т. д.).

# Метод .all
# Загружает данные из config/operating_system.yml, мапит их в объекты OperatingSystem и кэширует в переменной @all.

# Метод .find(key)
# Ищет объект операционной системы по ключу.