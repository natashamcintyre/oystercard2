class Journey
  attr_reader :entry, :exit
  PENALTY_FARE = 6
  MIN_FARE = 1

  def start(entry)
    @entry = entry
  end

  def finish(exit)
    @exit = exit
    self.fare
  end

  def complete?
    @entry && @exit
  end

  def fare
    self.complete? ? MIN_FARE : PENALTY_FARE
  end

  def log
    { :entry => entry, :exit => exit, :fare => self.fare }
  end

  def reset
    @entry, @exit = nil, nil
  end

end
