require 'ostruct'

module Cat
  def self.configuration
    @configuration ||= OpenStruct.new # или {}
  end

  def self.configure
    yield configuration if block_given?
  end
end

Cat.configure do |config|
  config.name = 'Mursik'
  config.color = 'Black'
  config.age = 3
end

p Cat.configuration.name
p Cat.configuration.color
p Cat.configuration.age
p Cat.configuration

# ещё вариант
class Client
  attr_accessor :consumer_key,
                :consumer_secret,
                :access_token,
                :access_token_secret

  def initialize
    yield self if block_given?
  end
end

client = Client.new do |config|
	config.consumer_key = "YOUR_CONSUMER_KEY"
	config.consumer_secret = "YOUR_CONSUMER_SECRET"
	config.access_token = "YOUR_ACCESS_TOKEN"
	config.access_token_secret = "YOUR_ACCESS_SECRET"
end

p client
