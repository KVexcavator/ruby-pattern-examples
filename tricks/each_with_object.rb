array = ["alpha", "beta", "omega"]

# конвертация в хаш без object
hash = {}
array.each do |element|
   hash[element] = element.upcase
end
return hash
#=> { "alpha"=>"ALPHA", "beta"=>"BETA", "omega"=>"OMEGA" }

# применение with_object

array.each_with_object({}) do |element, hash|
  hash[element] = element.upcase
end
#=> { "alpha"=>"ALPHA", "beta"=>"BETA", "omega"=>"OMEGA" }

array = ["John", "Joe", "Marcel", "John", "AJ", "Marcel", "John"]
array.each_with_object(Hash.new(0)) do |element, hash|
   hash[element] += 1
end
#=> { "John"=>3, "Joe"=>1, "Marcel"=>2, "AJ"=>1 }

# явное создание нового массива
array = ["tangerine", "peach", "apricot"]
array.each_with_object([]) do |element, new_array|
   new_array << element + "crayon"
   new_array << element + "marker"
end
