#!/usr/bin/env ruby
# ./data.rb | ./stdin.rb 2 100 4
args = ARGV
data = STDIN.read
data = data.split("\n")
headers = data.shift.split(" ")
p header_1_index = headers.index("Header-2")
p data[5]
if data[2]
  puts "OK"
else
  puts "Warning"
end
