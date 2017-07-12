require "journey"
require 'oyster_card'

describe Journey do

	  let(:entry_station) { double :station }
		let(:exit_station) { double :station }
	  subject(:journey) { described_class.new }

	  describe '#start_journey' do
	  	it 'should add the entry station to journey' do
	  		expect{ journey.start_journey(entry_station) }.to change { journey.entry_station }.from(nil).to entry_station
	  	end
	  end

		describe '#end_journey' do
			it 'should add the exit station to journey' do
				expect{ journey.end_journey(exit_station) }.to change { journey.exit_station }.from(nil).to exit_station
			end
		end


	describe 'in_progress' do

		context 'journey in progress' do
			it 'should return true' do
				expect(journey.in_progress?).to eq true
			end
		end

		context 'when journey is complete' do
			before { journey.end_journey(exit_station) }
			it 'should return false' do
				expect(journey.in_progress?).to eq false
			end
		end
	end

	describe 'fare' do

		context 'journey completed successfully' do

			before do
				journey.start_journey(entry_station) 
				journey.end_journey(exit_station)
			end

			it 'should return the minium fare of £1' do
				expect(journey.fare).to eq OysterCard::MINIMUM_FARE
			end
		end

		context "touched in, didn't touch out" do

			before do
				journey.start_journey(entry_station)
			end

			it 'should return a penalty fare of £6' do
				expect(journey.fare).to eq OysterCard::PENALTY_FARE
			end

		end
	end

end
