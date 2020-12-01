require 'oystercard'

describe Oystercard do
  it 'can create an instance of oystercard' do
    expect(subject).to be_kind_of(Oystercard)
  end

  it 'responds to the method balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'gives a default balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'responds to the method top_up' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  describe '#top_up' do
    it 'increases balance by amount' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "raises an error when top up exceeds #{Oystercard::LIMIT}" do
      message = "Balance cannot exceed #{Oystercard::LIMIT}"
      expect { subject.top_up(Oystercard::LIMIT+1) }.to raise_error message
    end
  end

  describe '#deduct' do
    it 'reduces balance by amount' do
      subject.top_up(50)
      subject.deduct(5)
      expect(subject.balance).to eq 45
    end
  end

  it 'responds to the method touch_in' do
    expect(subject).to respond_to(:touch_in)
  end

  describe '#touch_in' do
    it 'sets card state to in journey' do
      subject.touch_in
      expect(subject.state).to eq true
    end

    it 'raises error if balance is under £1' do
      expect { subject.touch_in }.to raise_error "Insufficient funds"
    end
  end

  it 'responds to the method in_journey?' do
    expect(subject).to respond_to(:in_journey?)
  end

  describe '#in_journey?' do
    it 'returns true when in journey' do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'returns false when not in journey' do
      expect(subject).not_to be_in_journey
    end

  end

  it 'responds to the method touch_out' do
    expect(subject).to respond_to(:touch_out)
  end

  describe '#touch_out' do
    it 'sets card state to not in journey' do
      subject.touch_in
      subject.touch_out
      expect(subject.state).to be false
    end
  end



end
