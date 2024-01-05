require './spec/spec_helper'
class Game
    attr_reader :board, :ship

    def initialize
        @board_player = Board.new
        @board_computer = Board.new
        @player_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine",2)]
        @computer_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine",2)]
    end

    def start
        loop do
            puts "Welcome to BATTLESHIP"
            puts "Enter p to play. Enter q to quit."

            player_answer = gets.chomp.downcase

            if player_answer == "p"
                play
            elsif player_answer == "q"
                break
            end
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
        player_place_ships(@player_ships.first)
        puts "Enter the squares for the Submarine (2 spaces):"
        player_place_ships(@player_ships.last)
        puts @board_player.render

    end

    def turn
        puts "==========COMPUTER BOARD=========="
        puts @board_computer.render
        puts "==========PLAYER BOARD=========="
        puts @board_player.render(true)
        shot_start
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
            coordinate = gets.chomp

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
        columns = ("A".."D").to_a
        rows = (1..4).to_a
        loop do
            start_column = columns.sample
            start_row = rows.sample
            coordinate = "#{start_column}#{start_row}"

            if @board_player.valid_coordinate?(coordinate) && !@board_player.cells[coordinate].fired_upon?
                @board_player.cells[coordinate].fire_upon
                #binding.pry
                shot_result = @board_player.cells[coordinate].render
                puts "My shot on #{coordinate} was a #{shot_result}."
                puts @board_player.render
                break
            end
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
        @computer_ships.each do |ship|
            coordinates = generate_random_coordinates(ship.length)
            until @board_computer.valid_placement?(ship, coordinates) do
                coordinates = generate_random_coordinates(ship.length)
            end
            @board_computer.place(ship, coordinates)
        end
    end



    def generate_random_coordinates(length)
        columns = ("A".."D").to_a
        rows = (1..4).to_a
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
# game = Game.new
# game.start
