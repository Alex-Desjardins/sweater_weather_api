require 'rails_helper'

RSpec.describe TrailService do
  it 'can return trail data when passed coordinates' do
    VCR.use_cassette('Evergreen location') do
      coordinates = {:lat=>39.633517, :lng=>-105.328888}

      results = TrailService.trail_data(coordinates)
      expect(results).to be_a(Hash)
      expect(results[:trails][0]).to have_key(:name)
      expect(results[:trails][0]).to have_key(:summary)
      expect(results[:trails][0]).to have_key(:difficulty)
    end
  end
end
