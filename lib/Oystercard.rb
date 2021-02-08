class Oystercard

  BALANCE_LIMIT = 90

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

  def deduct amount
    # raise "Insufficient funds" if @balance - amount < 0
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
    "Touched in"
  end

  def touch_out
    @in_journey = false
    "Touched out"
  end

end
