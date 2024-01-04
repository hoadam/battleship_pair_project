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

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false if coordinates.length != ship.length
    return false if !coordinates_available?(coordinates)

    columns = coordinates.map {|coordinate| coordinate[0]}
    rows = coordinates.map {|coordinate| coordinate[1].to_i}
    return true if consecutive_columns?(columns,rows,ship.length) || consecutive_rows?(columns, rows,ship.length)

    false
  end

  def same_row?(rows)
    rows.uniq.length == 1
  end

  def same_column?(columns)
    columns.uniq.length == 1
  end

  def consecutive_columns?(columns,rows,length)
    last_column = (columns[0].ord + (length-1)).chr
    same_row?(rows) && columns == (columns[0]..last_column).to_a
  end

  def consecutive_rows?(columns, rows,length)
    last_row = rows[0]+ (length-1)
    same_column?(columns) && rows == (rows[0]..last_row).to_a
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
       coordinates.each do |coordinate|
        cells[coordinate].place_ship(ship)
       end
    end
  end

  def coordinates_available?(coordinates)
    coordinates.all? do |coordinate|
    cells.key?(coordinate) && cells[coordinate].empty?
    end
  end

  def render(reveal_ship = false)
    board_header = "  A B C D \n"

    board = ("1".."4").map do |row|
      rendered_column = ("A".."D").map do |column|
        coordinate = "#{column}#{row}"
        cells[coordinate].render(reveal_ship)
      end
      "#{row} #{rendered_column.join(" ")} "
    end
    board_header + board.join("\n") + "\n"
  end
end
