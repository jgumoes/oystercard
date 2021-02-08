require "Oystercard.rb"

describe Oystercard do

  it 'new instance of oystercard shoud have balance 0' do
    expect(subject.balance).to eq 0
  end

  it 'oystercard can be topped up' do
    subject.top_up(3.50)
    expect(subject.balance).to eq 3.50
  end

  it "oystercard can't be topped up above the limit" do
    limit = Oystercard::BALANCE_LIMIT
    subject.top_up(limit)
    expect { subject.top_up(1) }.to raise_error "Reached Limit of #{limit}"
  end

end
