require "oyster_card"

describe OysterCard do

  subject(:oyster_card) { described_class.new }
  let(:top_up_amount) { 15 }
  let(:station){ double :station }
  let(:station2){ double :station2 }
  let(:journey) { double :journey }
  let(:entering){ oyster_card.touch_in(station, journey) }
  let(:exiting){ oyster_card.touch_out(station2) }
  before do
  			allow(journey).to receive(:start_journey)
  			allow(journey).to receive(:end_journey)
        allow(journey).to receive(:fare) { OysterCard::MINIMUM_FARE }
        allow(journey).to receive(:in_progress?) { false }
  		end

  describe 'a new card should contain no journeys' do
	  it 'should not have any stored journeys' do
		  expect(oyster_card.journeys).to eq []
	  end
  end

  describe '#top_up amount' do
    it 'can top up the balance' do
      expect{ oyster_card.top_up(top_up_amount) }.to change{ oyster_card.balance }.by top_up_amount
    end

    it 'cannot have a balance of more than £90' do
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
      before do
        oyster_card.top_up(top_up_amount)
        entering
      end
      it 'should store the journey in journeys' do
        expect(oyster_card.journeys).to eq [journey]
      end
      it 'charges penalty fare when not touched out' do
        allow(journey).to receive(:in_progress?) { true }
        allow(journey).to receive(:fare) { OysterCard::PENALTY_FARE }
        expect{ oyster_card.touch_in(station, journey) }.to change{ oyster_card.balance }.by -OysterCard::PENALTY_FARE
      end
    end
  end

  describe '#touch_out' do
	  before { oyster_card.top_up(top_up_amount) }

    it 'charges a penalty fare for not touching in' do
      allow(journey).to receive(:fare) { OysterCard::PENALTY_FARE }
      expect{ exiting }.to change{ oyster_card.balance }.by -OysterCard::PENALTY_FARE
    end

      it 'should end the journey' do
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
