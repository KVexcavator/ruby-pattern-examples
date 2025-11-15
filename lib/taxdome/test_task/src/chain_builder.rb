class ChainBuilder
  def self.build(state)
    # Monday's multiplier should be first
    MondayPenaltyHandler.new(
      PrimeIDHandler.new(
        DailyCountHandler.new(
          DailyLimitHandler.new(
            WeeklyLimitHandler.new(nil, state: state),
            state: state
          ),
          state: state
        ),
        state: state
      ),
      state: state
    )
  end
end
