class Cell
    attr_reader :coordinate,
                :ship,
                :fired_upon
    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
    end

    def empty?
        @ship.nil?
    end

    def place_ship(ship)
        @ship = ship
    end

    def fired_upon?
      @fired_upon
    end

    def fire_upon
      @fired_upon = true
      @ship.hit if @ship != nil
    end

    def render(reveal_ship = false)
      return "S" if reveal_ship == true && @ship != nil
      return "." if fired_upon == false
      return "M" if fired_upon == true && @ship == nil
      return "X" if fired_upon == true && @ship.sunk?
      return "H" if fired_upon == true && @ship != nil
    end
end
