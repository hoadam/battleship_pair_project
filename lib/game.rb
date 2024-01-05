require './spec/spec_helper'
class Game
    attr_reader :board, :ship

    def initialize
        @board_player = Board.new
        @board_computer = Board.new
        @ships= [Ship.new("Cruiser", 3), Ship.new("Submarine",2)]
    end

    def start
        puts "Welcome to BATTLESHIP"
        puts "Enter p to play. Enter q to quit."
        user_answer = gets.chomp.downcase
            if user_answer == "p"
                play
            else
                return
            end
        end

    def play
        setup
        turn
    end

    def setup
        place_ships_randomly
        puts "I have laid out my ships on the grid."
        puts "You now need to lay out your two ships."
        puts "The Cruiser is three units long and the Submarine is two units long."
        puts @board_player.render
        puts "Enter the squares for the Cruiser (3 spaces):"
        player_place_ships(@ships.first)
        puts "Enter the squares for the Submarine (2 spaces):"
        player_place_ships(@ships.last)
    end

    def turn
        puts "==========COMPUTER BOARD=========="
        @board_computer.render
        puts "==========PLAYER BOARD=========="
        @board_player.render(true)
        shot_start
    end

    def shot_start
        loop do
            player_shot
            computer_random_shot
            player_fired_cell = []
            @board_computer.cells.each do |cordinate, cell|
                if cell.fired_upon?
                    fired_cells << cell
                end
            end

            if fired_cells.all? { |cell| cell.render == "X" }
                puts "You won!"
                break
            end

            computer_fired_cell = []
            @board_player.cells.each do |coordinate, cell|
                if cell.fired_upon?
                    computer_fired_cells << value
                end
            end

            if fired_cells.all? { |cell| cell.render == "X" }
                puts "I won!"
                break
            end
        end
    end

    def player_shot
        puts "Enter the coordinate for your shot:"
        loop do
            player_input = gets.chomp

            if @board_computer.valid_coordinate?(player_input)
                if !@board_computer.cells[player_input].fired_upon?
                    @board_computer.cells[player_input].fire_upon
                    puts "Your#{show_result(player_input)}"
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
        columns = ("A".."D").to_a
        rows = (1..4).to_a
        loop do
            start_column = columns.sample
            start_row = rows.sample
            coordinate = "#{start_column}#{start_row}"

            if @board_player.valid_coordinate?(coordinate) && !@board_player.cells[coordinate].fired_upon?
                @board_player.cells[coordinate].fire_upon
                puts "My #{show_result(coordinate)}"
                break
            end
        end
     end




     def show_result(coordinate)
        shot_result = @board_computer.cells[coordinate].render
        if shot_result == "M"
            puts "shot on #{coordinate} was a miss."
        elsif shot_result == "H"
            puts "shot on #{coordinate} was a hit."
        else
            puts "shot on #{coordinate} was a hit and ship has been sunk."
        end
     end



    def player_place_ships(ship)
        loop do
            coordinates = gets.chomp.split(" ")
            if @board_player.valid_placement?(ship, coordinates)
                @board_player.place(ship, coordinates)
                puts @board_player.render(true)
                break
            else
                puts "Those are invalid coordinates. Please try again:"
            end
        end
    end

    def place_ships_randomly
        @ships.each do |ship|
            loop do
                coordinates = generate_random_coordinates(ship.length)
                if @board_computer.valid_placement?(ship, coordinates)
                    @board_computer.place(ship, coordinates)
                    break
                end
            end
        end
    end



    def generate_random_coordinates(length)
        columns = ("A".."D").to_a
        rows = (1..4).to_a
        start_column = columns.sample
        start_row = rows.sample
        orientation = ["horizontal","vertical"].sample
        if orientation == "horizontal"
            end_column_index = columns.index(start_column) + length -1
            end_column = columns[end_column_index]
            coordinates = (start_column .. end_column).map { |column| "#{column}#{start_row}"}
        else
            end_row = start_row + length -1
            coordinates = (start_row..end_row).map { |row| "#{start_column}#{row}"}
        end

        coordinates
    end




end
game = Game.new
game.start
