class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys
  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Balance cannot exceed #{LIMIT}" if @balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(entry_station)
    @journey = Journey.new
    fail "Insufficient funds" if @balance < MIN_FARE
    @entry_station = entry_station
    @journey
  end

  def in_journey?
    @entry_station
  end

  def touch_out(exit_station)
    @journey.finished(exit_station)
    self.deduct(MIN_FARE)
    @exit_station = exit_station
    @journeys << { :entry_station => entry_station, :exit_station => @journey.exit_station }
    @entry_station = nil
    @exit_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
