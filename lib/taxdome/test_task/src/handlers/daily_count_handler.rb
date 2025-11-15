class DailyCountHandler < BaseHandler
  MAX = 3

  def allow?(req)
    state.daily_count(req.customer_id, req.time) < MAX
  end

  def call(req)
    return reject(req) unless allow?(req)

    state.add_count(req.customer_id, req.time)
    next_handler ? next_handler.call(req) : accept(req)
  end
end
