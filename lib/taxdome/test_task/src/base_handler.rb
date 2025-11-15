class BaseHandler
  attr_reader :next_handler, :state

  def initialize(next_handler = nil, state:)
    @next_handler = next_handler
    @state = state
  end

  def call(request)
    return reject(request) unless allow?(request)

    if next_handler
      next_handler.call(request)
    else
      accept(request)
    end
  end

  private

  def reject(request)
    { "id" => request.id, "customer_id" => request.customer_id, "accepted" => false }
  end

  def accept(request)
    { "id" => request.id, "customer_id" => request.customer_id, "accepted" => true }
  end

  def allow?(_req)
    raise NotImplementedError
  end
end
