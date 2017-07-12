require "oyster_card"

describe OysterCard do

  subject(:oyster_card) { described_class.new }
  let(:top_up_amount) { 15 }
  let(:station){ double :station }
  let(:station2){ double :station2 }
  let(:journey) { double :journey }
  let(:entering){ oyster_card.touch_in(station, journey) }
  let(:exiting){ oyster_card.touch_out(station2) }
  before { allow(journey).to receive(:start_journey) }

  describe 'a new card should contain no journeys' do
	  it 'should not have any stored journeys' do
		  expect(oyster_card.journeys).to eq []
	  end
  end

  describe '#top_up amount' do
    it 'can top up the balance' do
      expect{ oyster_card.top_up(top_up_amount) }.to change{ oyster_card.balance }.by top_up_amount
    end

    it 'cannot have a balance of more than 90' do
  	  expect { oyster_card.top_up(OysterCard::MAXIMUM_BALANCE+1) }
  	  	.to raise_error "Maximum balance exceeded, please keep your balance at £#{OysterCard::MAXIMUM_BALANCE} or below."
    end
  end

  describe '#touch_in' do
  	context 'balance is less than £1' do
    	it 'does not allow touch in if balance is less than £1' do
      		expect{ entering }.to raise_error "Seek Assistance: not enough money!"
    	end
  	end
	  context 'enough balance on card' do
      before { oyster_card.top_up(top_up_amount) }
      it 'stores a new journey in journeys array' do
        expect{ entering }.to change{ oyster_card.journeys.length }.from(0).to 1
      end
    end

  end

  describe '#touch_out' do
	  before { oyster_card.top_up(top_up_amount) }
	    it 'should store the journey in journeys' do
	 	    entering
        exiting
	 	    expect(oyster_card.journeys).to eq [journey]
	    end

      it 'should end the journey' do
        allow(journey).to receive(:in_progress?) { false }
        entering
        exiting
        expect(oyster_card.in_journey?).to be false
      end

      it 'will have balance deducted when touching out' do
  	    oyster_card.top_up(top_up_amount)
  	    entering
        expect{ exiting }.to change{ oyster_card.balance }.by -OysterCard::MINIMUM_FARE
      end
   end
end
