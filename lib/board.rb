class Board
  attr_reader :cells

  def initialize
    @cells = create_cells
  end

  def create_cells
    cells = {}
    columns = ["A","B","C","D"]
    rows = [1, 2, 3, 4]
    columns.each do |letter|
      rows.each do |number|
        coordinate = "#{letter}#{number}"
        cells[coordinate] = Cell.new(coordinate)
      end
    end

    cells
  end
end
