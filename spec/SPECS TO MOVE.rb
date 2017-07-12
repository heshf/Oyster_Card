describe '#touch_out' 


do
	 # before { oyster_card.top_up(top_up_amount) }
	 # it 'should store the exit station' do
	 # 	exiting
	 # 	expect(oyster_card.exit_station).to eq station2
	 # end




	  it 'should store the journey in journeys' do
	 	entering
        exiting
	 	expect(oyster_card.journeys).to eq [{station => station2}]
	 end





    # it 'is not on a journey when touched out' do
    #   oyster_card.top_up(top_up_amount)
    # 	entering
    # 	exiting
    # 	expect(oyster_card.in_journey?).to be false
    # end
  end