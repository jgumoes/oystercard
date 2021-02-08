class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :history

  def initialize
    @balance = 0
    @limit = BALANCE_LIMIT
    @history = []
  end

  def top_up amount
    raise "Reached Limit of #{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def in_journey?
    entry_station != nil
  end

  def touch_in station_id
    raise "Insufficient funds" if @balance < MINIMUM_FARE
    @history << {station_in: station_id, station_out:nil}
    @entry_station = station_id
    "Touched in"
  end

  def touch_out station_id
    @history.last[:station_out] = station_id
    deduct MINIMUM_FARE
    @entry_station = nil
    "Touched out"
  end

  private

  def deduct amount
    @balance -= amount
  end

end
