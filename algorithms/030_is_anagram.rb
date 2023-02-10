# Две строки являются анаграммами, если содержат одни и те же буквы, но не обязательно в одинаковом порядке (регистр не имеет значения)

def is_anagram(s1,s2)
  s1 = s1.delete(' ').downcase
  s2 = s2.delete(' ').downcase
  if s1.chars.sort == s2.chars.sort
    return true
  end
  false
end

p s1 = 'Emperor Octavian'
p s2 = 'Captain over Rome'
p is_anagram(s1,s2)
p "======"
p s1 = "Jod Dow"
p s2 = "Cristofer"
p is_anagram(s1,s2)
