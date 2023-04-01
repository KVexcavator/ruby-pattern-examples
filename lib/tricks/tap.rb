# class Object
#   def tap
#     yield self
#     self
#   end
# end

"let's go to walk"
  .split(" ")
  .tap { puts "#{_1.inspect}"}
# => ["let's", "go", "to", "walk"]



class Blah
  attr_accessor :name
end

blah = Blah.new.tap do |b|
  b.name = "Scammer"
end

p blah.name # => Scammer
