# https://dev.to/lccezinha/design-patterns-in-ruby-strategy-pattern-21he
# Стратегия — это поведенческий паттерн проектирования, который определяет семейство схожих алгоритмов и помещает каждый из них в собственный класс. После чего, алгоритмы можно заимозаменять прямо во время исполнения программы.

class BaseParser
  def parse(text)
    raise 'Must implement!'
  end
end

class XMLParser < BaseParser
  def parse(text)
    "<text>#{text}</text>"
  end
end

class JSONParser < BaseParser
  def parse(text)
    "{ text: #{text} }"
  end
end

class TextParser
  attr_reader :text, :parser

  def initialize(text, parser)
    @text = text
    @parser = parser
  end

  def parse
    puts(parser.parse(text))
  end
end

parser_xml = TextParser.new('My Text', XMLParser.new)
parser_xml.parse => "<text>My Text</text>"

parser_json = TextParser.new('My Text', JSONParser.new)
parser_json.parse => "{ text: My Text }"
