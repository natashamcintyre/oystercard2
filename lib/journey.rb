# class Journey
#   attr_reader :entry_station, :exit_station, :results
#   PENALTY_FARE = 80
#   MIN_FARE = 1

#   def initialize(entry_station)
#     PENALTY_FARE
#     @entry_station = entry_station
#     results = { :entry_station => entry_station, :exit_station => exit_station, :fare => fare }
#   end

#   def finish(exit_station)
#     @exit_station = exit_station
#   end

#   def fare
#     if @exit_station == nil
#       PENALTY_FARE
#     else
#       MIN_FARE
#     end
#   end

#   def complete?
#     MIN_FARE
#   end
# end

class Journey
  PENALTY_FARE = 6
  MIN_FARE = 1
  attr_reader :entry_station, :exit_station, :completed

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @completed = false
  end

  def finished(exit_station)
    @exit_station = exit_station
    if !!@entry_station
      @completed = true
    else
      @completed = false
    end
    self
  end

  def completed?
    @completed
  end

  def fare
    if completed == true
      MIN_FARE
    else
      PENALTY_FARE
    end
  end
end
