require 'rails_helper'

RSpec.describe 'Image GET request' do
  before :each do
    VCR.use_cassette('Dallas image') do
      get '/api/v1/backgrounds?location=Dallas'
      @image_json = JSON.parse(response.body, symbolize_names: true)
    end
  end

  it 'Image data for location; success' do
    # expect(response).to be_successful
    # expect(response.status).to eq(200)
  end
end
