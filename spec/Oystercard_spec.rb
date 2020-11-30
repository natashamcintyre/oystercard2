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

    it 'raises an error when top up exceeds 90' do
      expect { subject.top_up(100) }.to raise_error 'Balance cannot exceed 90'
    end
  end
end
