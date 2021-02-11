require 'journey'
describe Journey do 
  let(:station) { double :station, zone: 1 }
  
  it 'knows if a journey is not complete' do 
    expect(subject).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns itself when exiting a journey' do
    expect(subject.finish(station)).to eq(subject)
  end
  
  context "if no entry station given" do
    before(:each) do
      subject.finish(station)
    end

    it "has penalty fare" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it "completes the journey anyway" do
      expect(subject).to be_complete
    end
  end
  
  context 'if entry station given:' do 
    subject { described_class.new(entry_station = station) }
    
    it 'has a entry station' do 
      expect(subject.entry_station).to eq station
    end 

    it "has penalty fare when user forgets  to touch out, no exit station" do 
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end 

    context 'if given an exit station:' do
      let(:exit_station) { double :exit_station}
      before do 
        subject.finish(exit_station)
      end 

      it 'has an exit station' do 
        expect(subject.exit_station).to eq exit_station
      end 

      it 'calculates a fare' do
        expect(subject.fare).to eq MINIMUM_FARE
      end

      it 'knows that journey is complete' do 
        expect(subject.complete?).to eq true
      end
    end 
  end
end
