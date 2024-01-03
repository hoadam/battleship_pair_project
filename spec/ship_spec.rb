require './spec/spec_helper'

RSpec.describe Ship do
  let(:cruiser) {Ship.new("Cruiser", 3)}

  describe '#initialize' do
    it 'can initialize' do
      expect(cruiser).to be_a(Ship)
      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.length).to eq(3)
      expect(cruiser.health).to eq(3)
    end
  end

  describe '#sunk?' do
    it "returns false if the ship is not sunk" do
      expect(cruiser.sunk?).to eq(false)
    end
  end

  describe '#hit' do
    it "decreases the health of a ship by 1" do
      cruiser.hit

      expect(cruiser.health).to eq(2)

      2.times{cruiser.hit}

      expect(cruiser.sunk?).to eq(true)
    end
  end


end
