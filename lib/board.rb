class Board
  attr_reader :cells

  def initialize(columns =4,rows =4)
    @cells = create_cells(columns,rows)
    @columns = columns
    @rows = rows
  end

  def create_cells(columns,rows)
    cells = {}
    # columns = ["A","B","C","D"]
    # rows = [1, 2, 3, 4]

    columns = ("A"..("A".ord + columns - 1).chr).to_a
    rows = (1..rows).to_a

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
    return true if coordinates_available?(coordinates) && consecutive?(ship, coordinates)

    false
  end

  def consecutive?(ship, coordinates)
    columns = coordinates.map {|coordinate| coordinate[0]}
    rows = coordinates.map {|coordinate| coordinate[1].to_i}

    return true if consecutive_columns?(columns,rows,ship.length) ||
    consecutive_rows?(columns, rows,ship.length)
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
    # binding.pry
    board_header = "  " + ("A"..("A".ord + @columns - 1).chr).to_a.join(" ") + " \n"

    board = (1..@rows).map do |row|
      rendered_column = ("A"..("A".ord + @columns - 1).chr).map do |column|
        coordinate = "#{column}#{row}"
        cells[coordinate].render(reveal_ship)
      end
      "#{row} #{rendered_column.join(" ")} "
    end
    board_header + board.join("\n") + "\n"
  end
end
