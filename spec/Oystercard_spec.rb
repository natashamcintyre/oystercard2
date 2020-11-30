require 'oystercard'

describe Oystercard do
  it 'can create an instance of airport' do
    expect(subject).to be_kind_of(Oystercard)
  end

  it 'responds to the method balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'gives a default balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'responds to the method top up' do
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

  it 'responds to the method touch in' do
    expect(subject).to respond_to(:touch_in)
  end

end
