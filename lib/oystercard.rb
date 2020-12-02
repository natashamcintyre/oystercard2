class Oystercard
attr_reader :balance, :entry
LIMIT = 90
MIN_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Balance cannot exceed #{LIMIT}" if @balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(entry)
    fail "Insufficient funds" if @balance < MIN_FARE
    @entry = entry
  end

  def in_journey?
    @entry
  end

  def touch_out
    self.deduct(MIN_FARE)
    @entry = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
