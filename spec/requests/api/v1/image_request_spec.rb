require 'rails_helper'

RSpec.describe 'Image GET request' do
  before :each do
    VCR.use_cassette('Dallas image') do
      get '/api/v1/backgrounds?location=Dallas'
      @image_json = JSON.parse(response.body, symbolize_names: true)
    end
  end

  it 'Image data for location; success' do
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(@image_json[:data][:type]).to eq('image')
    expect(@image_json[:data]).to have_key(:attributes)
    expect(@image_json[:data][:attributes].keys.count).to eq(1)
    expect(@image_json[:data][:attributes]).to have_key(:image)
    expect(@image_json[:data][:attributes][:image].keys.count).to eq(3)
    expect(@image_json[:data][:attributes][:image]).to have_key(:location)
    expect(@image_json[:data][:attributes][:image][:location]).to be_a(String)
    expect(@image_json[:data][:attributes][:image]).to have_key(:image_url)
    expect(@image_json[:data][:attributes][:image][:image_url]).to be_a(String)
    expect(@image_json[:data][:attributes][:image]).to have_key(:credit)
    expect(@image_json[:data][:attributes][:image][:credit]).to be_a(Hash)
    expect(@image_json[:data][:attributes][:image][:credit].keys.count).to eq(3)
    expect(@image_json[:data][:attributes][:image][:credit]).to have_key(:source)
    expect(@image_json[:data][:attributes][:image][:credit]).to have_key(:photographer)
    expect(@image_json[:data][:attributes][:image][:credit]).to have_key(:photographer_url)
  end
end
