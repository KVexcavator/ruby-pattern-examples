def fizzbuzz(n)
  n.times do |n|
    n += 1
    if n % 3 == 0 and n % 5 == 0
      puts 'FizzBuzz'
    elsif n % 3 == 0
      puts 'Fizz'
    elsif n % 5 == 0
      puts 'Buzz'
    else
      puts n
    end
  end
end

fizzbuzz(30)
