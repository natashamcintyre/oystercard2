require 'journey'

describe Journey do
  let(:card) { double :Oystercard }
  let(:entry) { double :entry }
  let(:exit) { double :exit }

  it "remembers the entry point" do
    subject.start(entry)
    expect(subject.entry).to eq entry
  end

  it "remembers the exit point" do
    subject.finish(exit)
    expect(subject.exit).to eq exit
  end

  describe "#complete?" do
    it "returns true when complete" do
      subject.start(entry)
      subject.finish(exit)
      expect(subject).to be_complete
    end

    it "returns false when no entry station" do
      expect(subject).not_to be_complete
    end

    it "returns false when no exit station" do
      subject.start(entry)
      expect(subject).not_to be_complete
    end
  end

  it { is_expected.to respond_to(:fare) }

  describe '#fare' do
    it "returns penalty fare if entry / exit are nil" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it "returns minimum fare if journey complete" do
      subject.start(entry)
      subject.finish(exit)
      expect(subject.fare).to eq Journey::MIN_FARE
    end
  end

  describe '#log' do
    it 'returns hash of journey' do
      subject.start(entry)
      subject.finish(exit)
      expect(subject.log).to eq({ :entry => entry, :exit => exit, :fare => Journey::MIN_FARE })
    end
  end

end
