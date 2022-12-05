def tower_of_hanoi(num, src, dst, temp)
  if num < 1
    return
  end
  tower_of_hanoi(num - 1, src, temp, dst)
  print "\n Move ", num, " disk from peg ", src, " to peg ", dst
  tower_of_hanoi(num - 1, temp, dst, src)
end

num = 4
print "The sequence of moves involved in the Tower of Hanoi are :"
tower_of_hanoi(num, 'A', 'C', 'B')
