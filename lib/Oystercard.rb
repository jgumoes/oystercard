class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @limit = BALANCE_LIMIT
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
    @entry_station = station_id
    "Touched in"
  end

  def touch_out
    deduct MINIMUM_FARE
    @entry_station = nil
    "Touched out"
  end

  private

  def deduct amount
    @balance -= amount
  end

end
