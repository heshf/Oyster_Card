require_relative 'oyster_card'
class Station
  attr_reader :zone
  def initialize(zone)
    fail "zone doesn't exist" if zone != 1
    @zone = zone
  end


end
