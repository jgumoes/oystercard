class Journey
 attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @is_complete = false
    @entry_station = entry_station
  end
  
  def complete?
    @is_complete
  end

  def fare
    return PENALTY_FARE if @entry_station == nil || @exit_station == nil
    MINIMUM_FARE
  end 

  def finish(exit_station)
    @is_complete = true
    @exit_station = exit_station
    self
  end

end
