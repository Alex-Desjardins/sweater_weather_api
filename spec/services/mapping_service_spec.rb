require 'rails_helper'

RSpec.describe MappingService do
  it 'can return mapping data when passed start and stop locations' do
    VCR.use_cassette('Evergreen mapping') do
      start = "Denver,CO"
      stop = "39.633517,-105.328888"

      results = MappingService.mapping_data(start, stop)
      expect(results).to be_a(Hash)
      expect(results).to have_key(:route)
      expect(results[:route]).to have_key(:distance)
    end
  end
end
