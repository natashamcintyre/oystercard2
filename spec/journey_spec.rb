require "journey"
RSpec.describe Journey do
  let(:exit_station) { double :exit_station, zone: 1 }
  let(:entry_station) { double :entry_station, zone: 1 }
  # let(:completed) { double :completed, zone: 1 }
  it "knows if a journey is not complete" do
    expect(subject).not_to be_completed
  end

  it "has a penalty fare by default" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
    expect(subject.finished(exit_station)).to eq(subject)
  end

  context "given an entry_station station" do
    subject { described_class.new(entry_station: entry_station) }

    # it "has an entry_station station" do
    #   expect(subject.entry_station).to eq entry_station
    # end

    it "returns a penalty fare if no exit_station station given" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context "given an exit_station station" do
      let(:other_station) { double :other_station }

      before do
        subject.finished(exit_station)
      end

      it "calculates a fare" do
        expect(subject.fare).to eq 1
      end

      it "knows if a journey is complete" do
        expect(subject).to be_completed
      end
    end
  end
end
