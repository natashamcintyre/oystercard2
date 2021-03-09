require "oystercard"

describe Oystercard do
  let(:entry) { double :entry }
  let(:exit) { double :exit }
  let(:journey) { double :Journey }
  let(:subject) { described_class.new(journey) }

  limit = Oystercard::LIMIT

  it { is_expected.to respond_to(:balance) }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it "gives a default balance of 0" do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do
    it "increases balance by amount" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "raises an error when top up exceeds #{limit}" do
      message = "Balance cannot exceed #{limit}"
      expect { subject.top_up(limit + 1) }.to raise_error message
    end
  end

  # describe '#deduct' do
  #   it 'reduces balance by amount' do
  #     subject.top_up(50)
  #     subject.deduct(5)
  #     expect(subject.balance).to eq 45
  #   end
  # end

  it { is_expected.to respond_to(:touch_in) }

  describe "#touch_in" do
    it "sets card state to in journey" do
      allow(journey).to receive(:start)
      allow(journey).to receive(:entry) {true}
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry)
      expect(subject).to be_in_journey
    end

    it "raises error if balance is under MIN_FARE" do
      expect { subject.touch_in(entry) }.to raise_error "Insufficient funds"
    end

  end
  it { is_expected.to respond_to(:in_journey?) }

  describe "#in_journey?" do
    it "returns true when in journey" do
      allow(journey).to receive(:start)
      allow(journey).to receive(:entry) {true}
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry)
      expect(subject).to be_in_journey
    end

    it "returns false when not in journey" do
      allow(journey).to receive(:entry) { false }
      expect(subject).not_to be_in_journey
    end
  end

  it { is_expected.to respond_to(:touch_out) }

  describe "#touch_out" do
    before(:each) do
      allow(journey).to receive(:start)
      allow(journey).to receive(:finish) { Oystercard::MIN_FARE }
      allow(journey).to receive(:log) { { :entry => entry, :exit => exit } }
      allow(journey).to receive(:reset)
      allow(journey).to receive(:entry) { false }
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry)
    end
    it "sets card state to not in journey" do
      subject.touch_out(exit)
      expect(subject).not_to be_in_journey
    end

    it "deducts journey fare from balance" do
      expect { subject.touch_out(exit) }.to change { subject.balance }
    end
  end

  before(:each) do
    allow(journey).to receive(:start)
    allow(journey).to receive(:finish) { Oystercard::MIN_FARE }
    allow(journey).to receive(:log) { { :entry => entry, :exit => exit } }
    allow(journey).to receive(:reset)
  end

  it "stores journeys in history" do
    subject.top_up(15)
    subject.touch_in(entry)
    subject.touch_out(exit)
    expect(subject).to respond_to(:history)
  end
  it "stores journeys in history" do
    subject.top_up(15)
    subject.touch_in(entry)
    subject.touch_out(exit)
    expect(subject.history).to eq([{ :entry => entry, :exit => exit }])
  end
end
