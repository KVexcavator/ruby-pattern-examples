# https://github.com/chanks/pond !!!прменяются гемы
# https://blog.francium.tech/object-pool-design-pattern-when-and-how-to-use-one-5790fb3e5a93
# пул обьектов применяется когда цена создания инстансов очень высока, например при подключении к БД
# у обьектов пула есть жизненный цикл:Creation, Validation, Destroy.

# Допустим, вы сканируете веб-сайт, который не позволяет выполнять необработанные HTTP-вызовы, защищенные такими службами, как Incapsula или Cloudflare. Вам понадобится настоящий браузер, чтобы эмулировать поведение реального пользователя. Это означает, что вам нужно запустить настоящий браузер Chrome. Для этого мы можем использовать веб-драйвер Selenium. В атомарном потоке, где каждый процесс просто принимает один URL-адрес и должен возвращать html, один хром с поддержкой Selenium может открывать только одну страницу за раз. Если вы хотите распараллелить процесс, вам понадобится много браузеров Chrome.

# Предполагая, что конфигурация вашей системы поддерживает параллельный запуск 25 браузеров, у вас может быть максимум 25 браузеров Chrome. Например, sake, вам нужно посетить 5000 ссылок в общей сложности. Давайте назовем наш метод, который принимает URL в качестве входных данных и возвращает HTML в качестве выходных данных, как get_html.

def html_from_browser(url)
  browser = BrowserPool.instance.get_browser
  browser.navigate.to url
  html = browser.page_source
  BrowserPool.instance.release!(browser)
  return html
end

class BrowserPool
  # object pool дожен быть singleton
  include Singleton
  MAX_POOL_SIZE = 25
  def initialize
    # SizedQueue  похожа на обычную очередь, за исключением того, что она синхронна по своей природе, соотв имет методы push и pop
    @browsers = SizedQueue.new(MAX_POOL_SIZE)
    MAX_POOL_SIZE.times{ @browsers.push(new_browser) }
  end
  def get_browser
    @browsers.pop
  end
  def release!(browser)
    @browsers.push(browser)
  end
private
  def new_browser
    options = Selenium::WebDriver::Chrome::Options.new(args: ['--headless'])
    Selenium::WebDriver.for :chrome, options: options
  end
end
