# известый способ вызвать ruby file
ruby some.rb
# можно исполнить из строки
ruby -e 'puts "Hello world"'
# можно модифицировать вывод
printf "foo\nbar\n" | ruby -e 'STDIN.each { |line| puts line.upcase }'

# Если мы передаем Ruby ключ -n, а также -e, Ruby будет действовать так, как будто код, который мы ему передаем, был заключен в следующее:
while gets
  # execute code passed in -e here
end

# $_ — всегда указывает на последнюю строку, прочитанную методом gets
# так можно упростить модификацию вывода
printf "foo\nbar\n" | ruby -ne 'puts $_.upcase'
# print поджватывает $_ без явного указания
printf "foo\nbar\n" | ruby -ne 'print'
# также можно использовать для фильтрации
printf "foo\nbar\n" | ruby -ne 'print if $_.start_with? "f"'

# регулярные выражения также неявно работают с $_
printf "foo\nbar\n" | ruby -ne 'print if /^f/'

# Если мы вызываем Ruby с флагом -n или -p, Ruby создает для нас два глобальных метода: sub и gsub. Они действуют так же, как и их обычные строковые аналоги, но работают с $_ неявно.
# мы можем выполнять операции поиска и замены в наших строках ввода
echo 'COBOL is the best!' | ruby -ne 'print gsub("COBOL", "Ruby")'

# scores.txt  - допустим у нас есть файл содержит:
Bob 40
Alice 98
Gillian 100
Fred 67
# хотим вывести только имя любого студента, набравшего более 50 баллов на тесте
cat scores.txt | \
ruby -ne 'print if $_.split[1].to_i > 50' | \
ruby -ne 'puts $_.split.first'
# здесь можно для второго шага использовать команду cut
cat scores.txt | \
ruby -ne 'print if $_.split[1].to_i > 50' | \
cut -d' ' -f1

# Печать строк с ключом -p
# Используемый вместо -n переключатель -p действует аналогичным образом: он циклически перебирает каждую строку входных данных. Однако он идет немного дальше: после завершения работы нашего кода он всегда печатает значение $_.
while gets
  # execute code passed in -e here
  puts $_
end
# это полезно, когда мы ожидаем изменить и вывести каждую строку ввода
echo 'COBOL is the best!' | ruby -pe '$_.gsub!("COBOL", "Ruby")'
# или короче
echo 'COBOL is the best!' | ruby -pe 'gsub("COBOL", "Ruby")'