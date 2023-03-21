hash = {}
url = "https://domen.example.com"
p url.split(".") # => ["https://domen", "example", "com"]
p url.split(".",2) # => ["https://domen", "example.com"]
p host_name = url.split(".", 2)[1]
p hash.store(host_name, 1)
p hash # => {"example.com"=>1}
