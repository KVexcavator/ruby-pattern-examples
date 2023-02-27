def fizzbuzz(n)
  n.times do |n|
    n += 1
    if n % 3 == 0 and n % 5 == 0
      puts 'APingBPong'
    elsif n % 3 == 0
      puts 'APing'
    elsif n % 5 == 0
      puts 'BPong'
    else
      puts n
    end
  end
end

fizzbuzz(100)
