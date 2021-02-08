require "Oystercard.rb"

describe Oystercard do
  MINIMUM_FARE = Oystercard::MINIMUM_FARE
  limit = Oystercard::BALANCE_LIMIT

  it 'new instance of oystercard shoud have balance 0' do
    expect(subject.balance).to eq 0
  end

  it 'oystercard can be topped up' do
    subject.top_up(3.50)
    expect(subject.balance).to eq 3.50
  end

  it "oystercard can't be topped up above the limit" do
    subject.top_up(limit)
    expect { subject.top_up(1) }.to raise_error "Reached Limit of #{limit}"
  end

  # it "money can be deducted from oystercard" do
  #   subject.instance_variable_set(:@balance, 20)
  #   subject.send(:deduct, 1.60)
  #   expect(subject.balance).to eq 20 - 1.6
  # end

  it 'oystercard can touch in' do
    subject.instance_variable_set(:@balance, MINIMUM_FARE + 10)
    expect(subject.in_journey?).to eq false
    expect(subject.touch_in).to eq "Touched in"
    expect(subject.in_journey?).to eq true
  end

  it 'oystercard can touch out' do
    subject.instance_variable_set(:@in_journey, true)
    expect(subject.touch_out).to eq "Touched out"
    expect(subject.in_journey?).to eq false
  end

  it "oystercard can't touch in with insufficient funds" do
    expect { subject.touch_in }.to raise_error "Insufficient funds"
  end

  it 'oystercard balance should reduce by minimum fare' do
    subject.instance_variable_set(:@balance, MINIMUM_FARE + 10)
    subject.instance_variable_set(:@in_journey, true)
    expect { subject.touch_out }.to change{subject.balance}.by(-MINIMUM_FARE)
  end

end
