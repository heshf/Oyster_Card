require_relative 'oyster_card'

class Journey

  attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def in_progress?
  	@exit_station == nil
  end


end
