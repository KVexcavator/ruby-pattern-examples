class DailyLimitHandler < BaseHandler
  LIMIT = 5000

  def allow?(req)
    state.daily_amount(req.customer_id, req.time) + req.amount <= LIMIT
  end

  def call(req)
    return reject(req) unless allow?(req)

    state.add_daily(req.customer_id, req.time, req.amount)
    next_handler ? next_handler.call(req) : accept(req)
  end
end
