#
File.open("file.txt") do |file|
  contents = file.read
end
#
contents = File.read("file.txt")
