require "journey"

describe Journey do

  let(:entry_station) { double :station }
	let(:exit_station) { double :station }
  subject(:journey) { described_class.new(entry_station) }

  describe '#initialize' do
	  it'journey has an entry station but no exit station' do
	    expect(journey.entry_station).to eq(entry_station)
	  end
  end

	describe '#end_journey' do
		it 'should add the exit station to journey' do
			expect{ journey.end_journey(exit_station) }.to change { journey.exit_station }.from(nil).to exit_station
		end
	end







end
