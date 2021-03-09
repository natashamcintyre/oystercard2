require_relative './journey.rb'

class Oystercard
  attr_reader :balance, :history, :journeys
  LIMIT = 90
  MIN_FARE = Journey::MIN_FARE

  def initialize(journey = Journey.new)
    @balance = 0
    @history = []
    @journey = journey
  end

  def top_up(amount)
    raise "Balance cannot exceed #{LIMIT}" if @balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(entry)
    fail "Insufficient funds" if @balance < MIN_FARE

    @journey.start(entry)
  end

  def in_journey?
    @journey.entry
  end

  def touch_out(exit)
    self.deduct(@journey.finish(exit))
    @history << @journey.log
    @journey.reset
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
