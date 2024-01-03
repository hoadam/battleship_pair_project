require './spec/spec_helper'

RSpec.describe Cell do
  let(:cell_1) { Cell.new("B4") }

  describe '#initialize' do
    it 'can initialize' do
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to be_nil
    end
  end


end
