class Oystercard

  BALANCE_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @limit = BALANCE_LIMIT
  end

  def top_up amount
    raise "Reached Limit of #{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def deduct amount
    raise "Insufficient funds" if @balance - amount < 0
    @balance -= amount
  end
end
