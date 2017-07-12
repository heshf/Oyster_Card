require_relative 'oyster_card'

class Journey

attr_reader :entry_station

def initialize(entry_station)
@entry_station = entry_station
end


def start_journey
end

def end_journey
end


end
