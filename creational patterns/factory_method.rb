# http://rubyblog.pro/2016/10/factory-method-pattern-in-ruby
# Фабричный метод — это порождающий паттерн проектирования, который определяет общий интерфейс для создания объектов в суперклассе, позволяя подклассам изменять тип создаваемых объектов.

class CsvFormatter
  def format(data)
    return "" if data.empty?
    result = data.keys.join(",") + "\n"
    result += data.values.join(",") + "\n"
  end
end

class JsonFormatter
  def format(data)
    return "" if data.empty?
    data.to_json
  end
end

class Formatter
  def self.for(type)
    case type
    when 'csv'
      CsvFormatter.new
    when 'json'
      JsonFormatter.new
    else
      raise 'Unsupported type of report'
    end
  end
end

class ReportGenerator
  def self.generate(data, type)
    Formatter.for(type).format(data)
  end
end

report_data = { foo_key: "foo", bar_key: "bar", baz_key: "baz" }
ReportGenerator.generate(report_data, 'json') # => {"foo_key":"foo","bar_key":"bar","baz_key":"baz"}
