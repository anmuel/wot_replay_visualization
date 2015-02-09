require 'rails_helper'

describe WotReplaysHelper do
  describe 'country_code' do
    it 'returns the ISO country code for a wot-country-naming' do
      expect(helper.country_code('France')).to eq 'fr'
    end

    it 'ignores the casing of the input' do
      expect(helper.country_code('france')).to eq 'fr'
    end
  end
end
