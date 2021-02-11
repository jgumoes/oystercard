require_relative "./journey.rb"

class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :current_journey, :history

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
    return false if @current_journey == nil
    not @current_journey.complete?
  end

  def touch_in entry_station
    raise "Insufficient funds" if @balance < MINIMUM_FARE
     start_journey(entry_station)
    "Touched in"
  end

  def touch_out exit_station
    if !(in_journey?)
      start_journey
    end
    @current_journey.finish(exit_station)
    deduct @current_journey.fare
    @current_journey.complete?
    "Touched out"
  end

  private

  def start_journey entry_station = nil
    @current_journey = Journey.new(entry_station)
     @history << @current_journey 
  end

  def deduct amount
    @balance -= amount
  end

end
