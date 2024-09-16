# Попросите функцию KUniqueCharacters (str) взять переданный параметр str и найти самую длинную подстроку, которая содержит k уникальных символов, где k будет первым символом из строки. Подстрока будет начинаться со второй позиции в строке, потому что первым символом будет целое число k. Например: если str - «2aabbacbaa», есть несколько подстрок, каждая из которых содержит 2 уникальных символа, а именно: [«aabba», «ac», «cb», «ba»], но ваша программа должна возвращать «aabba», потому что она самая длинная подстрока. Если существует несколько самых длинных подстрок, вернуть первую встреченную подстроку с самой длинной длиной. k будет варьироваться от 1 до 6.
# Примеры
# Ввод: "3aabacbebebe"
# Выход: cbebebe
# Ввод: "2aabbcbbbadef"

def add_matchers(arr,k)
  result = []
  (arr.permutation(k).to_a).each do |item|
    result << '\A['+item.join('+?')+'+]+\Z'
  end
  result
end

def KUniqueCharacters(str)

  arr_pry = str.split('')
  k = arr_pry.shift.to_i
  substrings = split_word(arr_pry.join(''))
  matchers = add_matchers(arr_pry.uniq, k)
  test = []
  matchers.each do |m|
    test << substrings.grep(/#{m}/).max_by(&:length)
  end
  test.to_a.uniq.max_by(&:length)

end

# keep this function call here
puts KUniqueCharacters(STDIN.gets)
