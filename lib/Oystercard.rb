class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @limit = BALANCE_LIMIT
    @in_journey = false
  end

  def top_up amount
    raise "Reached Limit of #{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Insufficient funds" if @balance < MINIMUM_FARE
    @in_journey = true
    "Touched in"
  end

  def touch_out
    deduct MINIMUM_FARE
    @in_journey = false
    "Touched out"
  end

  private

  def deduct amount
    @balance -= amount
  end

end
