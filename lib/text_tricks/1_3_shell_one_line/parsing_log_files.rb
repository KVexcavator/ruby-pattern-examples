# with log

# достаем толко сообщения с ошибками
cat lib/text_tricks/1_3_shell_one_line/error_log | ruby -ne '$_ =~ /^\[.+\] \[error\] (.*)$/ and puts $1'

# Сортировка записей журнала гарантирует, что одни и те же записи появляются рядом друг с другом, что позволяет uniq исключить все дубликаты. Аргумент -c для uniq затем сообщает ему, сколько раз повторялась каждая повторяющаяся строка.
cat error_log \
| ruby -ne '$_ =~ /^\[.+\] \[error\] (.*)$/ and puts $1' \
| sort | uniq -c
# это выведет что то типа:
=begin
1653 Directory index forbidden
560 File does not exist bar.jpg
579 File does not exist baz.png
564 File does not exist foo.txt
1674 caught SIGTERM, shutting down
=end

# Аргументы -rn указывают сортировке сортировать в порядке убывания и сортировать «естественным образом». Выведем по возрастанию счетчика
cat error_log \
| ruby -ne '$_ =~ /^\[.+\] \[error\] (.*)$/ and puts $1' \
| sort | uniq -c | sort -rn | head -n 10
=begin
1674 caught SIGTERM, shutting down
1653 Directory index forbidden
579 File does not exist baz.png
564 File does not exist foo.txt
560 File does not exist bar.jpg
=end
