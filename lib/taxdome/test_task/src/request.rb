require 'json'
require 'time'

class Request
  attr_reader :id, :customer_id, :time
  attr_accessor :amount

  def initialize(json_line)
    data = JSON.parse(json_line)
    @id = Integer(data.fetch("id"))
    @customer_id = Integer(data.fetch("customer_id"))
    @amount = parse_amount(data.fetch("load_amount"))
    # There might be a problem with time zones here
    @time = Time.parse(data.fetch("time"))
  end

  private

  def parse_amount(str)
    str.delete("$").to_f
  end
end
