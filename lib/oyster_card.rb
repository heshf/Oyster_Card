class OysterCard

	attr_reader :balance, :journeys
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1

	def initialize
		@balance = 0
		@journeys = []
	end

	def top_up amount
		fail ("Maximum balance exceeded, please keep your balance at £#{MAXIMUM_BALANCE} or below.") if @balance+amount > MAXIMUM_BALANCE
		@balance += amount
	end


	def touch_in(station, journey = Journey.new)
		fail("Seek Assistance: not enough money!") if @balance < MINIMUM_FARE
		update_journey_entry_station(station, journey)
		store_new_journey(station, journey)
	end

	def touch_out(station)
		deduct(MINIMUM_FARE)
	end

	def in_journey?
		journeys.last.in_progress?
	end

	private

	def deduct fare
		@balance -= fare
	end

	def update_journey_entry_station(station, journey)
		journey.start_journey(station)
	end

	def store_new_journey(station, journey)
		@journeys << journey
	end


end
