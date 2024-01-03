require './spec/spec_helper'

RSpec.describe Cell do
  let(:cell_1) { Cell.new("B4") }
  let(:cruiser) { Ship.new("Cruiser", 3) }
  describe '#initialize' do
    it 'can initialize' do
      expect(cell_1.coordinate).to eq("B4")
      expect(cell_1.ship).to be_nil
    end
  end

  describe '#empty?' do
    it 'returns true if the cell has no ship' do
      expect(cell_1.empty?).to eq(true)
    end
  end

  describe '#place_ship' do
    it 'places ship on the cells' do
      cell_1.place_ship(cruiser)
      expect(cell_1.ship).to eq(cruiser)
      expect(cell_1.empty?).to eq(false)
    end
  end
end
