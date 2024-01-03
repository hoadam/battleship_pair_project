require './spec/spec_helper'

RSpec.describe Cell do
  let(:cell_1) { Cell.new("B4") }
  let(:cruiser) { Ship.new("Cruiser", 3) }
  describe '#initialize' do
    it 'can initialize' do
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to be_nil
    end
  end

  describe '#empty?' do
    it 'returns true if the cell has no ship' do
      expect(cell.empty?).to eq(true)
    end
  end

  describe '#place_ship' do
    it 'places ship on the cells' do
      cell.place_ship(cruiser)
      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to eq(false)
    end
  end
end
