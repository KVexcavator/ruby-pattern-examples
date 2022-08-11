# https://makandracards.com/alexander-m/39299-memento
# Снимок — это поведенческий паттерн проектирования, который позволяет делать снимки состояния объектов, не раскрывая подробностей их реализации. Затем снимки можно использовать, чтобы восстановить прошлое состояние объектов.

# Организатор, обиект чьё сотояне сохраняется
class Post
  attr_accessor :title, :body

  def initialize(title, body)
    @title, @body = title, body
  end

  def save
    PostVersion.new self
  end

  def rollback(version)
    @title = version.title
    @body  = version.body
  end
end

# Состояние или версия
class PostVersion
  attr_reader :title, :body

  def initialize(post)
    @title = post.title
    @body  = post.body
  end
end
# Опекун или хранитель версий
class VersionHistory
  attr_reader :versions

  def initialize
    @versions       = {}
    @version_number = 0
  end

  def add(version)
    @versions[@version_number] = version
    @version_number            += 1
  end

  def version(number)
    @versions[number]
  end
end
# Исползование
# создать Post и хранилище версий
post   = Post.new('My First Post', 'This is my first post. I hope people like it')
folder = VersionHistory.new

# сохранить Post в хранилище
folder.add(post.save)

# проверить статус
puts post.title
# => My First Post
puts post.body
# => This is my first post. I hope people like it

# Обновить Post и его состояние
post.title = 'My First Post now with a longer title!'
post.body  = "I hated my first introduction. I needed to rewrite it - here's the updated version"
folder.add(post.save)

puts post.title
# => My First Post now with a longer title!
puts post.body
# => I hated my first introduction. I needed to rewrite it - here's the updated version

# вернуть старую версию Post
post.rollback(folder.version(0))

puts post.title
# => My First Post
puts post.body
# => This is my first post. I hope people like it
