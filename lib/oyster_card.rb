class OysterCard

	attr_reader :balance
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1
	attr_reader :in_journey, :entry_station



	def initialize
		@balance = 0
		@in_journey = false
		@entry_station = nil
	end

	def top_up amount
		fail ("Maximum balance exceeded, please keep your balance at £#{MAXIMUM_BALANCE} or below.") if @balance+amount > MAXIMUM_BALANCE
		@balance += amount
	end


	def touch_in(location)
		fail("Seek Assistance: not enough money!") if @balance < MINIMUM_FARE
		# @in_journey = true
		@entry_station = location
	end

	def touch_out
		# @in_journey = false
		@entry_station = nil
		deduct(MINIMUM_FARE)
	end

	def in_journey?
		@entry_station != nil
	end

	private

	def deduct fare
		@balance -= fare
	end


end
