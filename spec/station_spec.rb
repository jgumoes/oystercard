require "station"

describe Station do
  subject { described_class.new(name: "Blackfriars", zone: 1)}

  it "is called 'Blackfriars'" do
    expect(subject.name).to eq "Blackfriars"
  end

  it "is in zone 1" do
    expect(subject.zone).to eq 1
  end
end