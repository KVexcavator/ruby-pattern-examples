# удалить повторяющееся слова

def delete_repeated_words(str)
  arr = str.split(".")[0].split(" ")
  dict = {}
  arr.each do |word|
    if dict.has_key? word
      arr.delete word
    else
      dict[word] = 1
    end
  end
  arr.join(" ") + "."
end

p delete_repeated_words("I am a self-taught programmer looking for a job as a programmer.")
