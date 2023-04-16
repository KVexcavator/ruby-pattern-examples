# Write code that will make this construction possible:
# 2.times.per_second { puts 'woooo!'}

class Enumerator
  def per_second(&block)
    tik = 1.0/self.size
    while
      sleep(tik)
      yield
    end
  end
end

2.times.per_second { puts 'woooo!'}
