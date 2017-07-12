require "journey"


describe Journey do

let(:entry_station) { double :station }

subject(:journey) { described_class.new(entry_station) }
	
describe 'initialize' do
	it'journey has an entry station but no exit station' do
	expect(journey.entry_station).to eq(entry_station)
	end
end


















end
