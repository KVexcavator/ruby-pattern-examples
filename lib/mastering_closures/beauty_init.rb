class Client
	attr_accessor :id_number, 
								:first_name,
								:last_name

	def initialize(options = {}, &block)
		options.each { |k,v| send("#{k}=", v) }
		instance_eval(&block) if block_given?
	end
end


client = Client.new({id_number: 1233488394893 }) do
	self.first_name = "Adam"
	self.last_name = "Smit"
end

p client