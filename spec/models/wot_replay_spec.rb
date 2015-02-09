require 'rails_helper'

describe WotReplay do
  let(:file_name) do
    File.join(__dir__, '..', 'fixtures',
              '20140622_0021_germany-RhB_Waffentrager_10_hills.wotreplay')
  end
  specify { expect(File.file?(file_name)).to be true }

  subject(:wot_replay) do
    described_class.new(replay: File.new(file_name))
  end

  it { is_expected.to be_valid }
  it { is_expected.to have_attached_file :replay }

  its(:country) { is_expected.to eq 'Germany' }
  its(:tank) { is_expected.to eq 'RhB_Waffentrager' }
  its(:map) { is_expected.to eq 'hills' }

  describe '#plain_meta_data' do
    subject { wot_replay.plain_meta_data }
    it { is_expected.to respond_to :[] }
    its([:tank]) { is_expected.to eq 'RhB_Waffentrager' }
    its([:country]) { is_expected.to eq 'germany' }
    its([:year]) { is_expected.to eq '2014' }
    its([:month]) { is_expected.to eq '06' }
    its([:day]) { is_expected.to eq '22' }
    its([:hour]) { is_expected.to eq '00' }
    its([:minute]) { is_expected.to eq '21' }
    its([:map]) { is_expected.to eq 'hills' }
    its([:count]) { is_expected.to eq '10' }
  end

  describe '#time' do
    subject { wot_replay.time }
    it { is_expected.to be_an_instance_of DateTime }
    its(:year) { is_expected.to eq 2014 }
    its(:month) { is_expected.to eq 06 }
    its(:day) { is_expected.to eq 22 }
    its(:hour) { is_expected.to eq 00 }
    its(:minute) { is_expected.to eq 21 }
  end

  describe '#valid?' do
    it 'is only valid if it can parse the file name correctly' do
      expect(described_class.new).to be_invalid
    end
  end
end
