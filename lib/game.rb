require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
    attr_reader :board, :ship
    attr_accessor :rows, :columns

    def initialize
        @rows = nil
        @columns = nil
        @board_player = nil
        @board_computer = nil
        @player_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine",2)]
        @computer_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine",2)]
    end

    def start
        catch(:finish) do
            loop do
                puts "Welcome to BATTLESHIP"
                puts "Enter p to play. Enter q to quit."

                player_answer = gets.chomp.downcase

                if player_answer == "p"
                    play
                elsif player_answer == "q"
                    return
                end
            end
        end
    end

    def play
        setup
        turn
    end

    def setup
        create_board
        computer_place_ships
        puts "I have laid out my ships on the grid."
        puts "You now need to lay out your two ships."
        puts "The Cruiser is three units long and the Submarine is two units long."
        puts @board_player.render
        player_place_ships
    end

    def create_board
        loop do
            puts "Enter the number of rows for the board:"
            rows = gets.chomp
            puts "Enter the number of columns for the board:"
            columns = gets.chomp
            if valid_input?(rows) && valid_input?(columns)
                @rows = rows.to_i
                @columns = columns.to_i
                @board_player = Board.new(@columns,@rows)
                @board_computer = Board.new(@columns,@rows)
                break
            else
                puts "Invalid input for the number of rows and columns!"
            end
        end
    end

    def valid_input?(input)
        input.to_i.to_s == input
    end

    def turn
        puts "==========COMPUTER BOARD=========="
        puts @board_computer.render
        puts "==========PLAYER BOARD=========="
        puts @board_player.render(true)
        shot_start
        puts "Do you want to play again? Y or N"
        player_answer = gets.chomp.downcase
        if  player_answer == "y"
            start
        elsif player_answer == 'n'
            throw :finish
        end
    end

    def shot_start
        loop do
            player_shot
            if @computer_ships.all? { |ship| ship.sunk?}
                puts "You won"
                return
            end

            computer_random_shot
            if @player_ships.all? { |ship| ship.sunk?}
                puts "I won"
                return
            end
        end
    end

    def player_shot
        puts "Enter the coordinate for your shot:"
        loop do
            coordinate = gets.chomp.upcase

            if @board_computer.valid_coordinate?(coordinate)
                if !@board_computer.cells[coordinate].fired_upon?
                    @board_computer.cells[coordinate].fire_upon
                    shot_result = @board_computer.cells[coordinate].render
                    puts "Your shot on #{coordinate} was a #{shot_result}."
                    puts @board_computer.render
                    break
                else
                    puts "coordinate has been fired on."
                end
            else
                puts "Please enter a valid coordinate:"
            end
        end
     end

    def computer_random_shot
        columns = ("A"..("A".ord + @columns - 1).chr).to_a
        rows = (1..@rows).to_a
        loop do
            start_column = columns.sample
            start_row = rows.sample
            coordinate = "#{start_column}#{start_row}"

            if @board_player.valid_coordinate?(coordinate) && !@board_player.cells[coordinate].fired_upon?
                @board_player.cells[coordinate].fire_upon

                shot_result = @board_player.cells[coordinate].render
                puts "My shot on #{coordinate} was a #{shot_result}."
                puts @board_player.render
                break
            end
        end
     end

    def player_place_ships
        @player_ships.each do |ship|
            puts "Enter the squares for the #{ship.name} #{ship.length} spaces:"

            loop do
                coordinates = gets.chomp.upcase.split(" ")
                if @board_player.valid_placement?(ship, coordinates)
                    @board_player.place(ship, coordinates)
                    puts @board_player.render(true)
                    break
                else
                    puts "Those are invalid coordinates. Please try again:"
                end
            end
        end
    end

    def computer_place_ships
        @computer_ships.each do |ship|
            coordinates = generate_random_coordinates(ship.length)
            until @board_computer.valid_placement?(ship, coordinates) do
                coordinates = generate_random_coordinates(ship.length)
            end
            @board_computer.place(ship, coordinates)
        end
    end

    def generate_random_coordinates(length)
        columns = ("A"..("A".ord + @columns - 1).chr).to_a
        rows = (1..@rows).to_a
        start_column = columns.sample
        start_row = rows.sample
        orientation = ["horizontal","vertical"].sample

        if orientation == "horizontal"
            end_column_index = columns.index(start_column) + length - 1
            end_column_index = columns.size - 1 if end_column_index >= columns.size
            end_column = columns[end_column_index]

            coordinates = (start_column .. end_column).map { |column| "#{column}#{start_row}"}
        else
            end_row = start_row + length -1
            end_row = rows.size - 1 if end_row >= rows.size
            coordinates = (start_row..end_row).map { |row| "#{start_column}#{row}"}
        end

        coordinates
    end
end
