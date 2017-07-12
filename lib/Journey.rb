require_relative 'oyster_card'

class Journey

  attr_reader :entry_station, :exit_station

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def in_progress?
  	@exit_station == nil
  end

  def fare
  	 @entry_station && @exit_station ? OysterCard::MINIMUM_FARE : OysterCard::PENALTY_FARE
  end
	
end
