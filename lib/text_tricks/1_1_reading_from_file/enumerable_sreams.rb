# Enumerable имеет методы map, reduce и пр.
=begin
входящий файл
127.0.0.1 - [10/Oct/2014:13:55:36] "GET / HTTP/1.1" 200 561
127.0.0.1 - [10/Oct/2014:13:55:36] "GET /images/logo.png HTTP/1.1" 200 23260
192.168.0.42 - [10/Oct/2014:14:10:21] "GET / HTTP/1.1" 200 561
192.168.0.91 - [10/Oct/2014:14:20:51] "GET /person.jpg HTTP/1.1" 200 46780
192.168.0.42 - [10/Oct/2014:14:20:54] "GET /about.html HTTP/1.1" 200 483
=end

requests = File.open("data/access_log") do |file|
  file
    # рубим массив по пробелам, на выходе массив хешей
    .map { |line| { ip: line.split[0], url: line.split[5] } }
    # получаем сгрупированный хеш хешей
    .group_by { |request| request[:ip] }
    #
    .each { |ip, requests| requests.map! { |r| r[:url] } }
end

=begin
исходящий файл
{
  "127.0.0.1" => [
    "/",
    "/images/logo.png"
  ],
    "192.168.0.42" => [
    "/",
    "/about.html"
  ],
    "192.168.0.91" => [
    "/person.jpg"
  ]
}
=end
