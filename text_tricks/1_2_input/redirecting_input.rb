#  стандартый ввод
print "What's your name? "
name = $stdin.gets.chomp
puts "Hi, #{name}!"

# вывод мозет быть пкркнаправлен(piped) серез скрипт на ruby
# to-uppercase.rb
# puts $stdin.read.upcase
$ echo "hello world" | ruby to-uppercase.rb
$ hostname | ruby to-uppercase.rb
$ whoami | ruby to-uppercase.rb

# например, имеем скрипт ./urls с содержанием
=begin
#!/usr/bin/env ruby
$stdin.each_line do |line|
  urls = line.scan(%r{https?://\S+})
  urls.each do |url|
    puts url
  end
end
=end

# и file.txt
# Alice's website is at http://www.example.com
# While Jane's website is at https://example.net and contains a useful blog.

$ chmod +x urls
$ printf "hello\nworld http://www.example.com/\nhttps://example.net/" | urls
$ cat file.txt | urls
# или как то так
$ cat /var/log/webserver/access | urls
$ curl http://example.com | urls
$ curl http://example.com | urls | xargs wget

# пайпы стартуют одновременно, пример
$ sleep 5 | echo "hello, world"

$ ruby stdout-async.rb | cat
=begin будет исполнятся очень
stdout-async.rb
100.times do
  "hello world".each_char do |c|
    print c
    sleep 0.1
  end
  print "\n"
end
=end

$ ruby stdout-sync.rb | cat
=begin синхранное исполнение
stdout-sync.rb
$stdout.sync = true

100.times do
  "hello world".each_char do |c|
    print c
    sleep 0.1
  end
  print "\n"
end
=end
