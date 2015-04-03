require 'rails_helper'

describe ChartSerie do
  %i(name criteria attribute).each do |attribute|
    before do
      subject.send("#{attribute}=", 1)
    end

    its(attribute) { is_expected.to be_a String }
  end

  describe '#for' do
    it 'sets the criteria for this serie in a builder fashion' do
      chart_serie = ChartSerie.new(attribute: 'map').for('hills')

      expect(chart_serie).to be_a ChartSerie
      expect(chart_serie.name).to eq 'hills'
      expect(chart_serie.criteria).to eq 'hills'
    end
  end

  describe '#with' do
    it 'fills the data according to the given replays array with the amount ' +
     'of replays matching the criteria for the attribute' do
      wot_replay = Fabricate(:wot_replay)
      chart_serie = ChartSerie.new(attribute: 'map').for(wot_replay.map).with([wot_replay])
      expect(chart_serie.data).to eq([1])
    end
  end

  describe '#to_hash' do
    it 'returns a hash with name and data key' do
      actual = ChartSerie.new(name: 'name').to_hash
      expect(actual).to have(2).items
      expect(actual[:name]).to eq 'name'
      expect(actual).to have_key :data
    end
  end
end
