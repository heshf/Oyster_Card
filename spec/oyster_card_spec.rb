require "oyster_card"

describe OysterCard do

  subject(:oyster_card) { described_class.new }
  let(:top_up_amount) { 15 }
  let(:station){ double :station }
  # let(:fare) { 2.80 }

  describe '#top_up amount' do
    it 'can top up the balance' do
      expect{ oyster_card.top_up(top_up_amount) }.to change{ oyster_card.balance }.by top_up_amount
    end

    it 'cannot have a balance of more than 90' do
  	  expect { oyster_card.top_up(91) }.to raise_error "Maximum balance exceeded, please keep your balance at £#{OysterCard::MAXIMUM_BALANCE} or below."
    end
  end

  describe '#touch_in' do
    before { oyster_card.top_up(top_up_amount) }
    it 'should store the entry station' do
      oyster_card.touch_in(station)
      expect(oyster_card.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    before { oyster_card.top_up(top_up_amount) }
    it 'should forget the entry station' do
      oyster_card.touch_out
      expect(oyster_card.entry_station).to eq nil
    end
    it 'should end the journey' do
      oyster_card.touch_in(station)
      oyster_card.touch_out
      expect(oyster_card.in_journey?).to be false
    end
  end



  describe '#in_journey?' do
    it 'should be false by default' do
      expect(oyster_card.in_journey?).to be false
    end

    it 'is on a journey' do
      oyster_card.top_up(top_up_amount)
    	oyster_card.touch_in(station)
    	expect(oyster_card.in_journey?).to be true
    end
  end

  context 'balance is less than £1' do

    it 'does not allow touch in if balance is less than £1' do
      expect{ oyster_card.touch_in(station) }.to raise_error "Seek Assistance: not enough money!"
    end
  end

  it 'will have balance deducted when touching out' do
  	oyster_card.top_up(top_up_amount)
  	oyster_card.touch_in(station)
    expect{ oyster_card.touch_out }.to change{ oyster_card.balance }.by -OysterCard::MINIMUM_FARE
  end
end
