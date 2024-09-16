# Попросите функцию HTMLElements (str) прочитать передаваемый параметр str, который будет строкой элементов HTML DOM и обычного текста. Будут использоваться следующие элементы: b, i, em, div, p. Например: если str равно "<div> <b> <p> hello world </p> </b> </div>", то эта строка элементов DOM вложена правильно, поэтому ваша программа должна вернуть строку true.

# Если строка вложена неправильно, верните первый встреченный элемент, где, если его изменить на другой элемент, будет получена правильно отформатированная строка. Если строка отформатирована неправильно, то нужно будет изменить только один элемент. Например: если str равно «<div> <i> hello </i> world </b>», тогда ваша программа должна вернуть строку div, потому что если первый элемент <div> был заменен на <b>, строка будет правильно отформатирован.
def split_word s
  (0..s.length).inject([]) do |ai,i|
    (1..s.length-i).inject(ai) do |aj,j|
      aj << s[i,j]
    end
  end.uniq
end
def HTMLElements(str)

  # grep all tags
  o = str.scan(/<\w{1,3}>/)
    .map {|t| t=t[1...-1]}
  c = str.scan(/<\/\w{1,3}>/)
    .map {|t| t=t[2...-1]}
  b = Hash.new(0)
  (o+c).each do |v|
    b[v] += 1
  end
  result = []
  b.each do |k,v|
    result << k if v.odd?
  end
  if result.empty?
    true
  else
    result.first
  end
  
end

# keep this function call here 
puts HTMLElements(STDIN.gets)
