require 'station'

  describe Station do
    subject(:station) { described_class.new(zone1) }
    let(:zone1) {1}
    let(:zone2) {50}
    it 'display the zone the station is in' do
      expect(station.zone).to eq zone1
    end
    it "raise an error if zone doesn't exist" do
      expect { Station.new(zone2) }.to raise_error "zone doesn't exist"
    end
  end
