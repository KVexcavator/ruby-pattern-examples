class PrimeIDHandler < BaseHandler
  def prime?(n)
    return false if n <= 1
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  end

  def allow?(req)
    return true unless prime?(req.id)

    !state.prime_used?(req.time) && req.amount <= 9999
  end

  def call(req)
    if prime?(req.id)
      return reject(req) unless allow?(req)
      state.set_prime_used(req.time)
    end

    next_handler ? next_handler.call(req) : accept(req)
  end
end
