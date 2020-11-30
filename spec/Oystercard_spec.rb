require 'oystercard'

describe Oystercard do
  it 'can create an instance of airport' do
    expect(subject).to be_kind_of(Oystercard)
  end

  it 'responds to the method balance' do
    expect(subject).to respond_to(:balance)
  end

end
