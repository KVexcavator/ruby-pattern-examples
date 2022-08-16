# побитовое чтение
=begin
03JAN1990   23.4-0.4  25.1-0.3  26.6 0.0  28.6 0.3
10JAN1990   23.4-0.8  25.2-0.3  26.6 0.1  28.6 0.3
17JAN1990   24.2-0.3  25.3-0.3  26.5-0.1  28.6 0.3
=end
File.open("data/wksst8110.for") do |file|
  puts file.read(10)
  4.times do
    puts file.read(9)
    puts file.read(4)
  end
end

File.open("data/wksst8110.for") do |file|
  weeks = []
  until file.eof?
  week = {
    date: file.read(10).strip,
    temps: {}
  }
  [:nino12, :nino3, :nino34, :nino4].each do |region|
    week[:temps][region] = {
      temp: file.read(9).to_f,
      change: file.read(4).to_f
    }
  end
  file.read(1)
  weeks << week
end

# пропустить 63 байта
File.open("data/wksst8110.for") do |file|
  file.seek(63)
  file.read(10)
  # => " 10JAN1990"
end
