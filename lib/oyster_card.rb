class OysterCard

	attr_reader :balance
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1
	attr_reader :entry_station, :exit_station, :journeys


	def initialize
		@balance = 0
		@in_journey = false
		@entry_station = nil
		@exit_station = nil
		@journeys = []
	end

	def top_up amount
		fail ("Maximum balance exceeded, please keep your balance at £#{MAXIMUM_BALANCE} or below.") if @balance+amount > MAXIMUM_BALANCE
		@balance += amount
	end


	def touch_in(station)
		fail("Seek Assistance: not enough money!") if @balance < MINIMUM_FARE
		# @in_journey = true
		@entry_station = station
	end

	def touch_out(station2)
		# @in_journey = false
		deduct(MINIMUM_FARE)
		@exit_station = station2
		@journeys << {entry_station => exit_station}
	end


	def in_journey?
		@exit_station == nil
	end

	private

	def deduct fare
		@balance -= fare
	end


end
