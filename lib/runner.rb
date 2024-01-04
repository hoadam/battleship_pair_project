require './spec/spec_helper'
class Runner
        attr_reader :board, :ship
    def initialize
    @board = Board.new
    @ships= [Ship.new("Cruiser", 3),Ship.new("Submarine",2)]
    
    end

        def start
            puts "Welcome to BATTLESHIP"
            puts "Enter p to play. Enter q to quit."
            user_answer = gets.chomp
            if user_answer == "p"
            play
            end
        end

        def play

        end






        def place_ships_randomly
            @ships.each do |ship|
                loop do
                    coordinates = generate_random_coordinates(ship.length)
                    if @board.valid_placement?(ship,coordinates)
                    board.place(ship , coordinates)
                   
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
            binding.pry
            coordinates
          end




end

runner = Runner.new

runner.place_ships_randomly
