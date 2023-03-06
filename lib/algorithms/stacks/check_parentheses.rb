# нужно проверить, что за каждой открывающей круглой скобкой следует закрывающая круглая скобка
# (str(1)) # Balanced
# (Hi!)) # Not balanced

# чётчики не помогут, если  столкнутся с подобной строкой? ")( )("

# вернёт true, если все в порядке
def check_parentheses(str)
  stack = []
  str.each_char do |c|
    if c == "("
      stack.push(c)
    end
    if c == ")"
      if stack.size == 0
        return false
      else
        stack.pop
      end
    end
  end
  stack.size == 0
end

p check_parentheses("(str(1))")
p check_parentheses("(Hi!))")
p check_parentheses(")( )(")
