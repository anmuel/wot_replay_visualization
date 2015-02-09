require 'rails_helper'

describe MapChartPresenter do
  its(:wot_replays) { is_expected.to eq [] }

  describe '#categories' do
    subject { described_class.new.categories }
    it { is_expected.to be_present }
    it { is_expected.to include('Mines') }
  end

  describe '#series' do
    it { is_expected.to respond_to :series }
  end
end
