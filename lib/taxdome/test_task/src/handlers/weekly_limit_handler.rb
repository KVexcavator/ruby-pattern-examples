class WeeklyLimitHandler < BaseHandler
  LIMIT = 20_000

  def allow?(req)
    state.weekly_amount(req.customer_id, req.time) + req.amount <= LIMIT
  end

  def call(req)
    return reject(req) unless allow?(req)

    state.add_weekly(req.customer_id, req.time, req.amount)
    next_handler ? next_handler.call(req) : accept(req)
  end
end
