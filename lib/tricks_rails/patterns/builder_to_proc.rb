# Паттерн Builder-to-Proc в Rails — это способ передавать блок (do ... end или { ... }) как proc (объект Proc) в другой метод, чтобы тот метод сам решил, когда и как выполнить этот блок.
# Используется, когда метод вызывает переданный блок внутри себя — не сразу, а передавая его дальше.
# Удобен в методах, создающих структуры: HTML, формы, JSON и т.п.
# Пример Rails
# JSON or CSV from a third party API
raw_users = [{email: "a@a.com"}, ...]

class BaseBuilder
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def build = raise(NotImplementError)
  
  def self.to_pros
    proc {|params| new(params).build}
  end
end

class UserBuilder < BaseBuilder
  def build = User.new(params)
end

users = raw_users.map &UserBuilder
users # =>[#<User:0x... email="a@a.com"> ...]
