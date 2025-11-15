class MondayPenaltyHandler < BaseHandler
  MULTIPLIER = 2

  def allow?(_req)
    true
  end

  def call(req)
    if req.time.wday == 1
      req.amount *= MULTIPLIER
    end

    next_handler ? next_handler.call(req) : accept(req)
  end
end
