require './spec/spec_helper'

RSpec.describe Board do
    let(:board) { Board.new }
    let(:cruiser) {Ship.new("Cruiser", 3)}
    let(:submarine) {Ship.new("Submarine", 2)}
    describe '#initialize' do
        it 'can initialize' do
            expect(board).to be_a(Board)
            expect(board.cells.length).to eq(16)
        end
    end

    describe '#valid_coordinate?(coordinate)' do
        it 'returns true if coordinate valid' do
            expect(board.valid_coordinate?("A1")).to eq(true)
            expect(board.valid_coordinate?("D4")).to eq(true)
            expect(board.valid_coordinate?("A5")).to eq(false)
            expect(board.valid_coordinate?("E1")).to eq(false)
            expect(board.valid_coordinate?("A22")).to eq(false)

        end
    end

    describe '#valid_placement?(ship,coordinates)' do
        it 'returns false if the number of coordinate is not same as ship length' do
            expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
            expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
        end

        it 'returns false if coordinates are not consecutive' do
            expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
            expect(board.valid_placement?(submarine, ["A1", "C1"])).to be(false)
            expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false)
            expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)

        end

        it 'returns false if coordinates are diagonal' do
            expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
            expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
        end

        it 'returns true if all conditions above are met ' do

            expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
            expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)

        end
    end

    describe 'placing ship' do
        it 'places ship on cells in a board' do
            board.place(cruiser, ["A1","A2","A3"])
            cell_1 = board.cells["A1"]   
            cell_2 = board.cells["A2"]
            cell_3 = board.cells["A3"] 
            expect(cell_1.ship).to eq(cruiser)
            expect(cell_2.ship).to eq(cruiser)
            expect(cell_3.ship).to eq(cruiser)
            expect(cell_3.ship).to eq(cell_2.ship)
        end
        it 'ships cannot overlap' do
            board.place(cruiser, ["A1","A2","A3"])
            expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
        end
    end
end
