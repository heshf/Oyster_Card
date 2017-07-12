
class Station

  attr_reader :zone, :name

  def initialize(zone, name)
    fail "zone doesn't exist" if  zone > 7
    @zone = zone
    @name = name
  end
end
