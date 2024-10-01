# Изменений вносить не требуется
def transform_word(word, transformation)
  transformation.call(word)
end

# Лямбды для разных трансформаций
uppercase_lambda = ->(str) { str.upcase }
chars_lambda = ->(str) { str.chars}

# Вызов функции с лямбдой
p transform_word("котик", uppercase_lambda)
p transform_word("котик", chars_lambda )
