require 'rails_helper'

RSpec.describe LocationService do
  it 'can return location data when passed an address/city' do
    VCR.use_cassette('Denver location') do
      results = LocationService.location_data('denver,co')
      require "pry"; binding.pry
      expect(results).to be_a(Hash)
      expect(results[:latLng]).to be_a(Hash)
      expect(results[:latLng][:lat]).to be_a(Float)
      expect(results[:latLng][:lng]).to be_a(Float)
    end
  end
end
