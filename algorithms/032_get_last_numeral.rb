# получить последнююю цифру в строке

def get_last_numeral(str)
  str.split(/[^[[:word:]]]+/)
  .select { |el| el.match?(/[[:digit:]]/) }
  .last.to_i
end

p str = "Buy 1 get 12 free"
p get_last_numeral(str)
