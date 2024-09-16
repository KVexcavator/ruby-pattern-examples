txt = "Еще древние египтяне и греки использовали в своих постройках природные формы. Представителя известной философской школы стоиков считало человека частью природы, а постижение ее законов и их использование в художественном творчестве — необходимостью.
В древней Греции ваяние с его культом человеческого тела было очень тесно связано с зодчеством. Великий теоретик древности Витрувий писал: «Если, следовательно, природа так устроила тело человека, что его члены своими пропорциями отвечают его общему начертанию, то, кажется мне, вполне основательно древние установили то правило, что и при возведении построек соразмерности отдельных частей здания точно соответствовали общему внешнему виду сооружения».
Научное осознание и глубокое изучение функций и структур живой природы стали возможными лишь в середине XX в. Бионические принципы применяются при проектировании конструкций, зданий, архитектурных комплексов и городов. Многие конструктивно-тектонические системы: балки, колонны, плиты, рамы, складки, оболочки-скорлупы напоминают корни, ветви, стволы я листья растений, скелеты и панцири животных, строение человеческого тела."

blah = "blah blahblah bla blahe blah so as blah blahblah bla blahe blah so as"

class RequestUniqArticle
  require 'net/http'
  require 'uri'
  require 'json'

  def initialize (text)
    @text = text
    @text_uid = String.new
    @status_message = "Текст ожидает отправки на проверку."
    @admin_error = Array.new
  end

  # later put into secrets
  URL_SERVICE = "https://api.text.ru/post"
  KEY_SERVICE = "..."

  # doc api error code
  AUTHOR_ERR_CODE = [110, 111, 112, 113]
  WAIT_ERR_CODE = [140, 143, 144, 145, 181, 183]

  def status_message
    @status_message
  end

  def send_text_to_service  
    # run service whith a text's params
    result = run_service("text", @text)
    # if service return text_uid {"text_uid"=>"601d3f4688fdd"}
    if result.key?("text_uid")
      @text_uid = result["text_uid"]
      @status_message = "Текст отправлен на проверку."
    elsif result.key?("error_code")
      # if service return error code
      case result["error_code"]
      when *WAIT_ERR_CODE
        @status_message = "Ошибка сервера. Попробуйте позднее"
      when *AUTHOR_ERR_CODE
        @status_message = result["error_desc"]
      else
        @status_message = "Серсис не доступен. Свяжитесь с администратором"
        @admin_error << result
      end
    end    
    # puts result    
  end

  def get_check_result
    @status_message = "Ожидаем результатов проверки текста на уникальность одну минуту."
    sleep 60
    unless @text_uid==""
      result = run_service("uid", @text_uid)
      if result.key?("text_unique")
        value_text_unique = result["text"].to_f
        case value_text_unique
        when 0.00..60.00
          @status_message = "Текст не уникален. Рузультат: #{value_text_unique}%."
        else
          @status_message = "Текст уникален. Результат: #{value_text_unique}%."
        end
      elsif  result.key?("error_code")
        case result["error_code"]
        when *WAIT_ERR_CODE
          @status_message = "Ошибка сервера. Попробуйте позднее"
        else
          @status_message = "Сервис не доступен. Свяжитесь с администратором"
          @admin_error << result
      end
      end
      
    end
    # puts result
  end

  def run_service(type,value)
    begin
      request  = { "userkey": KEY_SERVICE, }
      request[type] = value
      url = URI.parse(URL_SERVICE)
      response = Net::HTTP.post_form(url, request)
      result   = JSON.parse(response.body)
      # !! shoild handling are errors by log
    rescue => ex
      puts ex
    end
  end

end

req = RequestUniqArticle.new(txt)
req.send_text_to_service
puts req.status_message
req.get_check_result
puts req.status_message
