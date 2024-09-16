def TimeDifference(strArr)


    hashes_arr = []
    dif = 0
    strArr.each do |str|
      sub_arr = []
      re = %r{(?<HH>\d\d?):(?<MM>\d\d)(?<prefix>\w{2})}
      m = re.match str
      if m[:prefix] == 'am'
        if m[:HH] == '12'
          sub_arr << 0
        else
          sub_arr << m[:HH].to_i
        end
      else
        if m[:HH] == '12'
          sub_arr << 12
        else 
          sub_arr << (m[:HH].to_i + 12)
        end
      end
      sub_arr << m[:MM].to_i
      hashes_arr << sub_arr
    end
    hashes_arr=hashes_arr.sort do |a,b| 
    a[0] <=> b[0]
    end
    res_arr = []; i = 0
    while i < (hashes_arr.length-1)
      a = hashes_arr[i][0]*60 + hashes_arr[i][1]
      b = hashes_arr[i+1][0]*60 + hashes_arr[i+1][1]
      dif = b - a
      res_arr << dif
      i += 1
    end
    result = res_arr.min
end

# keep this function call here 
puts TimeDifference(STDIN.gets)
