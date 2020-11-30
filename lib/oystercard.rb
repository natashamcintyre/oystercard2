class Oystercard
attr_reader :balance, :state
LIMIT = 90

  def initialize
    @balance = 0
    @state = false
  end

  def top_up(amount)
    raise "Balance cannot exceed #{LIMIT}" if @balance + amount > LIMIT

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @state = true
  end

  def in_journey?
    @state
  end

  def touch_out
    @state = false
  end

end
