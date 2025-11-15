os: ubuntu 24.10
ruby version: 3.2.2
author: Kalandarishvili Vyacheslav
mob KZ: +7(702)116 30 10
telega: @kvexcavator

run
```bush
ruby run.rb
```
minitest
```bush
# single test
ruby -Ilib:test test/test_daily_limit_handler.rb
# all tests
ruby -Ilib:test -e "Dir.glob('./test/test_*.rb').sort.each { |f| require f }"
```