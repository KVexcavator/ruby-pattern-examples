- Ruby 3.x https://rubygems.org

```
bundle install
```
```
bundle exec rspec
```
https://hub.docker.com/_/ruby
docker build -t ruby-pattern .
docker run -it ruby-pattern sh
docker run ruby-pattern ruby lib/example.rb
