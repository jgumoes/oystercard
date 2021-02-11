require "Oystercard.rb"

describe Oystercard do
  MINIMUM_FARE = Oystercard::MINIMUM_FARE
  limit = Oystercard::BALANCE_LIMIT
  let(:waterloo) { double :station }
  before (:each) do
    allow(waterloo).to receive(:ID?).and_return(:WATERLOO)
    subject.instance_variable_set(:@balance, MINIMUM_FARE + 1)
    subject.instance_variable_set(:@history, [{station_in:'a',station_out:nil}])
  end

  it "oystercard isn't in journey when created" do
    expect(subject.in_journey?).to eq false
  end

  it 'oystercard can be topped up' do
    expect { subject.top_up(3.50) }.to change {subject.balance}.by(3.50)
  end

  it 'oystercard can touch in' do
    expect(subject.in_journey?).to eq false
    expect(subject.touch_in(waterloo.ID?)).to eq "Touched in"
    expect(subject.in_journey?).to eq true
  end

  it 'oystercard can touch out' do
    subject.instance_variable_set(:@in_journey, true)
    expect(subject.touch_out(waterloo.ID?)).to eq "Touched out"
    expect(subject.in_journey?).to eq false
  end

  it 'oystercard balance should reduce by minimum fare' do
    subject.instance_variable_set(:@in_journey, true)
    subject.touch_in(:waterloo)
    expect { subject.touch_out(waterloo.ID?) }.to change{subject.balance}.by(-MINIMUM_FARE)
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
