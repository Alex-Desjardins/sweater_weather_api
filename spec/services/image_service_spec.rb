require 'rails_helper'

RSpec.describe ImageService do
  it 'can return an image when passed a city' do
    VCR.use_cassette('Denver image') do
      results = ImageService.location_image('Denver')
      expect(results).to be_a(Hash)
      expect(results).to have_key(:url)
      expect(results[:url]).to be_a(String)
      expect(results).to have_key(:photographer)
      expect(results[:photographer]).to be_a(String)
    end
  end
end
