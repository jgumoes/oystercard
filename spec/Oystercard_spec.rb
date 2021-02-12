require "Oystercard.rb"
require "journey.rb"
# I've decided to import journey.rb instead of dependancy injection, because
# issues with the journey class should be caught in journey_spec.rb.
# This file should therefore check that the two classes play nicely with eachother

describe Oystercard do
  MINIMUM_FARE = Oystercard::MINIMUM_FARE
  limit = Oystercard::BALANCE_LIMIT
  let(:waterloo) { double :station }
  let(:station) { double :station, zone: 1 }
  before (:each) do
    allow(waterloo).to receive(:ID?).and_return(:WATERLOO)
    subject.instance_variable_set(:@balance, MINIMUM_FARE + 10)   # should this number be replaced with a variable?
    subject.instance_variable_set(:@history, [{station_in:'a',station_out:nil}])
  end

  it "oystercard isn't in journey when created" do
    expect(subject.in_journey?).to eq false
  end

  it 'oystercard can be topped up' do
    expect { subject.top_up(3.50) }.to change {subject.balance}.by(3.50)
  end

  context "touching in:" do
    it 'oystercard can touch in' do
    expect(subject.in_journey?).to eq false
    expect(subject.touch_in(waterloo)).to eq "Touched in"
    expect(subject.in_journey?).to eq true
    end
  end

  context "touching out" do

    context "after touching in:" do
      before (:each) do
        subject.touch_in(station)
      end

      it 'oystercard can touch out' do
        expect(subject.touch_out(waterloo)).to eq "Touched out"
        expect(subject.in_journey?).to eq false
      end

      it 'oystercard balance should reduce by minimum fare' do
        expect { subject.touch_out(waterloo) }.to change{subject.balance}.by(-MINIMUM_FARE)
      end
    end

    context "without touching in:" do
      it "oystercard balance should reduce by penalty fare" do
        expect { subject.touch_out(waterloo) }.to change{subject.balance}.by(-Journey::PENALTY_FARE)
      end
    end
  end

  context "oystercard starts with no money" do
    before(:each) do
      subject.instance_variable_set(:@balance, 0)
    end

    it 'new instance of oystercard shoud have balance 0' do
      expect(Oystercard.new().balance).to eq 0
    end

    it "oystercard can't be topped up above the limit" do
      subject.top_up(limit)
      expect { subject.top_up(1) }.to raise_error "Reached Limit of #{limit}"
    end

    it "oystercard can't touch in with insufficient funds" do
      expect { subject.touch_in(waterloo.ID?) }.to raise_error "Insufficient funds"
    end
  end

  # context "remembering stations" do

  #   it "remembers the entry station" do
  #     subject.touch_in(waterloo.ID?)
  #     expect(subject.entry_station).to eq waterloo.ID?
  #   end

  #   it "forgets the entry station after touching out" do
  #     subject.touch_out(waterloo.ID?)
  #     expect(subject.entry_station).to eq nil
  #   end

  #   it 'should print journey history' do
  #     subject = Oystercard.new()
  #     subject.top_up(10)
  #     stations = [{station_in:'a', station_out:'b'},{station_in:'c', station_out:'d'}]
  #     stations.each { |s| subject.touch_in(s[:station_in]); subject.touch_out(s[:station_out])}
  #     expect(subject.history).to eq(stations)
  #   end

  #   it 'new instance of oystercard shoud have no history' do
  #     expect(Oystercard.new().history).to eq []
  #   end

  # end
end
