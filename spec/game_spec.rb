require './spec/spec_helper'

RSpec.describe Game do
  let(:game) {Game.new}
  describe '#initialize' do
      it 'can initialize' do
          expect(game).to be_a(Game)
      end
  end
end
