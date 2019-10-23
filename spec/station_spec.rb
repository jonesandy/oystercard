require 'station'

describe Station do
  
  it 'has a name' do
    expect(subject.name).to eq "name"
  end

  it 'has a zone' do
    expect(subject.zone).to eq "zone"
  end
end
