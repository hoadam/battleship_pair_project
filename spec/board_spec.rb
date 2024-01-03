require './spec/spec_helper'

RSpec.describe Board do
    let(:board) { Board.new }
    describe '#initialize' do
        it 'can initialize' do
            expect(board).to be_a(Board)
            expect(board.cells.length).to eq(16)
        end
    end
    
    describe 'valid_coordinate?' do
        it 'return true if coordinate valid' do
            expect(board.valid_coordinate?("A1")).to eq(true)
            expect(board.valid_coordinate?("D4")).to eq(true)
            expect(board.valid_coordinate?("A5")).to eq(false)
            expect(board.valid_coordinate?("E1")).to eq(false)
            expect(board.valid_coordinate?("A22")).to eq(false)

        end
    end
end