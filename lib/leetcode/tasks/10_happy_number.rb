# Input: 19
# Output: true
# Explanation: 
# 1**2 + 9**2 = 82
# 8**2 + 2**2 = 68
# 6**2 + 8**2 = 100
# 1**2 + 0**2 + 0**2 = 1
# is_happy(4) not happy : stack level too deep (SystemStackError)

def is_happy(n)
    if n == 1
        puts true
    # if cicle have 4 = SystemStackError
    elsif n == 4
        puts false
    else
        n = n.digits.reduce(0){|s,f| s + f**2}
        puts n
        begin 
          is_happy(n)
        rescue SystemStackError
          puts false
        end 
    end
end
is_happy(4)
