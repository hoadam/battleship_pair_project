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
            end
        end

    def play

    end

    def setup
        place_ships_randomly
        puts "I have laid out my ships on the grid."
        puts "You now need to lay out your two ships."
        puts "The Cruiser is three units long and the Submarine is two units long."
        puts @board_player.render
        puts "Enter the squares for the Cruiser (3 spaces):"
        user_place_ships(@ships.first)
        puts "Enter the squares for the Submarine (2 spaces):"
        user_place_ships(@ships.last)

    end

    def user_place_ships(ship)
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
        binding.pry
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
game.setup
