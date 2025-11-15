#!/usr/bin/env ruby

require_relative "src/request"
require_relative "src/state_store"
require_relative "src/base_handler"
Dir["./src/handlers/*.rb"].each { |f| require_relative f }
require_relative "src/chain_builder"

input_path = ARGV[0] || "input.txt"
output_path = "output.txt"

state = StateStore.new
chain = ChainBuilder.build(state)

File.open(output_path, "w") do |out|
  File.foreach(input_path) do |line|
    request = Request.new(line)
    result = chain.call(request)
    out.puts(result.to_json)
  end
end
