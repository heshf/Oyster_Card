require 'station'

  describe Station do
    context 'zone1' do
    subject(:station) { described_class.new(zone1) }
    let(:zone1) {1}
    it 'display the zone the station is in' do
      expect(station.zone).to eq zone1
    end
  end
  context 'zone50' do
    subject(:station1) { described_class.new(zone2) }
    let(:zone2) {50}
    it "raise an error if zone doesn't exist" do
      expect {station1}.to raise_error "zone doesn't exist"
    end
  end
end
