# Паттерн Репозиторий (Repository) — это шаблон проектирования, который используется для абстрагирования логики доступа к данным. Он служит для того, чтобы отделить логику бизнес-приложения от деталей хранения и получения данных (например, из базы данных или API). Репозиторий управляет набором объектов доменной модели и обеспечивает механизм для выполнения CRUD-операций (создание, чтение, обновление, удаление).

class User
  attr_accessor :id, :name, :email

  def initialize(id, name, email)
    @id = id
    @name = name
    @email = email
  end
end

class UserRepository
  # Найти пользователя по ID
  def find_by_id(id)
    raise NotImplementedError, 'Этот метод должен быть реализован'
  end

  # Получить всех пользователей
  def all
    raise NotImplementedError, 'Этот метод должен быть реализован'
  end

  # Сохранить нового пользователя
  def save(user)
    raise NotImplementedError, 'Этот метод должен быть реализован'
  end

  # Удалить пользователя
  def delete(user)
    raise NotImplementedError, 'Этот метод должен быть реализован'
  end
end

class InMemoryUserRepository < UserRepository
  def initialize
    @users = []
  end

  # Найти пользователя по ID
  def find_by_id(id)
    @users.find { |user| user.id == id }
  end

  # Получить всех пользователей
  def all
    @users
  end

  # Сохранить нового пользователя
  def save(user)
    existing_user = find_by_id(user.id)
    if existing_user
      existing_user.name = user.name
      existing_user.email = user.email
    else
      @users << user
    end
  end

  # Удалить пользователя
  def delete(user)
    @users.delete_if { |u| u.id == user.id }
  end
end

class InMemoryUserRepository < UserRepository
  def initialize
    @users = []
  end

  # Найти пользователя по ID
  def find_by_id(id)
    @users.find { |user| user.id == id }
  end

  # Получить всех пользователей
  def all
    @users
  end

  # Сохранить нового пользователя
  def save(user)
    existing_user = find_by_id(user.id)
    if existing_user
      existing_user.name = user.name
      existing_user.email = user.email
    else
      @users << user
    end
  end

  # Удалить пользователя
  def delete(user)
    @users.delete_if { |u| u.id == user.id }
  end
end

# Создаем новый репозиторий
user_repo = InMemoryUserRepository.new

# Добавляем пользователей
user_repo.save(User.new(1, 'Alice', 'alice@example.com'))
user_repo.save(User.new(2, 'Bob', 'bob@example.com'))

# Получаем всех пользователей
users = user_repo.all
puts "Все пользователи:"
users.each { |user| puts "#{user.id}: #{user.name} (#{user.email})" }

# Находим пользователя по ID
user = user_repo.find_by_id(1)
puts "\nНайден пользователь с ID 1:"
puts "#{user.id}: #{user.name} (#{user.email})"

# Обновляем пользователя
user_repo.save(User.new(1, 'Alice Updated', 'alice.new@example.com'))

# Удаляем пользователя
user_repo.delete(user)
