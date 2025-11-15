class Client
	ATTRS = [:first_name, :last_name, :id_number]
  attr_accessor(*ATTRS)

	def initialize(options = {}, &block)
		options.each { |k,v| send("#{k}=", v) }
		instance_eval(&block) if block_given?
	end

	ATTRS.each do |attr|
    define_method(attr) do |value|
      send("#{attr}=", value)
    end
  end
end


client = Client.new({id_number: 1233488394893 }) do
	first_name "Adam"
	last_name "Smit"
end

p client