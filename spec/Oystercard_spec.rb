require "Oystercard.rb"

describe Oystercard do

  it 'new instance of oystercard shoud have balance 0' do
    expect(subject.balance).to eq 0
  end

  it 'oystercard can be topped up' do
    subject.top_up(3.50)
    expect(subject.balance).to eq 3.50
  end

end
