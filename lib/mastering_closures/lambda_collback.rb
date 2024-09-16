# Реализация callback в Ruby с lambda
# Например, необходимо узнать, успешно ли был создан отчет, и сразу же отправить его своему боссу. Однако, если что-то пойдет не так, следует уведомить менеджера.

require 'ostruct' #подключает OperStruct

good_report = OpenStruct.new(to_csv: "59.99,Great Success")
bad_report = OpenStruct.new(to_csv: nil)

class Generator
	attr_reader :report

	def initialize(report)
		@report = report
	end

	def run
		report.to_csv
	end
end

class Notifier
	attr_reader :generator, :callbacks

	def initialize(generator, callbacks)
		@generator = generator
		@callbacks = callbacks
	end

	def run
		result = generator.run
		if result
			callbacks.fetch(:on_success).call(result)
		else
			callbacks.fetch(:on_failure).call
		end
	end
end

# нужно обработать два случая:
Notifier.new(Generator.new(good_report),
		on_success: lambda { |r| puts "Send #{r} to boss@mail.ru" },
		on_failure: lambda { puts "Send email to me@mail.ru"}
		).tap do |n|
	n.run #=> Send 59.99,Great Success to boss@mail.ru
end

Notifier.new(Generator.new(bad_report),
		on_success: lambda { |r| puts "Send #{r} to boss@mail.ru" },
		on_failure: lambda { puts "Send email to manager@mail.ru"}
		).tap do |n|
	n.run #=> Send email to manager@mail.ru
end