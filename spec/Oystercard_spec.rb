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
      expect(subject.top_up(10)).to eq 10
    end
  end

end
