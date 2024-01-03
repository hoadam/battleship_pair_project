require './spec/spec_helper'

RSpec.describe Cell do
  let(:cell_1) { Cell.new("B4") }
  let(:cruiser) { Ship.new("Cruiser", 3) }
  let(:cell_2) {Cell.new("C3")}
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

  describe '#fired_upon?' do
    it 'returns false if the cell has not been fired on' do
      expect(cell_1.fired_upon?).to eq(false)
    end
  end

  describe '#fire_upon' do
    it 'fire on the cell and damage the ship health if the ship is on the cell' do
      cell_1.place_ship(cruiser)
      cell_1.fire_upon
      expect(cruiser.health).to eq(2)
      expect(cell_1.fired_upon?).to eq(true)
    end
  end
  describe '#render' do
    it 'returns the firing status of a cell and if it has a ship' do
      expect(cell_1.render).to eq(".")

      cell_1.fire_upon
      expect(cell_1.render).to eq("M")

      cell_2.place_ship(cruiser)
      expect(cell_2.render).to eq(".")
      expect(cell_2.render(true)).to eq("S")
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")
      
      expect(cruiser.sunk?).to eq(false)
      cruiser.hit
      cruiser.hit
      expect(cruiser.sunk?).to eq(true)
      expect(cell_2.render).to eq("X")
    end
  end
end
