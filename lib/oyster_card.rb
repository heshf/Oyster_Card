require_relative 'journey'
require_relative 'station'

class OysterCard

	attr_reader :balance, :journeys
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1
	PENALTY_FARE = 6

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
		deduct(last_journey.fare) if in_journey?
		update_journey_entry_station(station, journey)
		store_new_journey(journey)
	end

	def touch_out(station)
		update_journey_exit_station(station) if in_journey?
		last_journey ? deduct(last_journey.fare) : deduct(PENALTY_FARE)
	end

	def in_journey?
		journeys.empty? ? false : last_journey.in_progress?
	end

	private

	def deduct fare
		@balance -= fare
	end

	def update_journey_entry_station(station, journey)
		journey.start_journey(station)
	end

	def update_journey_exit_station(station)
		last_journey.end_journey(station)
	end

	def store_new_journey(journey)
		@journeys << journey
	end

	def last_journey
		@journeys.last
	end

end
