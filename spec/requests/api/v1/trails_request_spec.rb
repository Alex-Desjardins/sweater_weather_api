require 'rails_helper'

RSpec.describe 'Trails GET request' do
  before :each do
    VCR.use_cassette('Telluride trails') do
      get '/api/v1/trails?location=telluride,co'
      @trails_json = JSON.parse(response.body, symbolize_names: true)
    end
  end

  it 'trails and forecast data for location; success' do
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(@trails_json[:data]).to have_key(:id)
    expect(@trails_json[:data][:type]).to eq("trail")
    expect(@trails_json[:data]).to have_key(:attributes)
    expect(@trails_json[:data][:attributes]).to have_key(:location)
    expect(@trails_json[:data][:attributes]).to have_key(:forecast)
    expect(@trails_json[:data][:attributes]).to have_key(:trails)

    expect(@trails_json[:data][:attributes][:location]).to be_a(String)
    expect(@trails_json[:data][:attributes][:location]).to_not be_a(Hash)

    expect(@trails_json[:data][:attributes][:forecast]).to be_a(Hash)
    expect(@trails_json[:data][:attributes][:forecast].keys.count).to eq(2)
    expect(@trails_json[:data][:attributes][:forecast]).to have_key(:summary)
    expect(@trails_json[:data][:attributes][:forecast]).to have_key(:temp)
    expect(@trails_json[:data][:attributes][:forecast]).to_not have_key(:time)
    expect(@trails_json[:data][:attributes][:forecast]).to_not have_key(:sunrise)
    expect(@trails_json[:data][:attributes][:forecast]).to_not have_key(:sunset)

    expect(@trails_json[:data][:attributes][:trails]).to be_an(Array)
    expect(@trails_json[:data][:attributes][:trails].first.keys.count).to eq(5)
    expect(@trails_json[:data][:attributes][:trails].first).to have_key(:name)
    expect(@trails_json[:data][:attributes][:trails].first).to have_key(:summary)
    expect(@trails_json[:data][:attributes][:trails].first).to have_key(:difficulty)
    expect(@trails_json[:data][:attributes][:trails].first).to have_key(:location)
    expect(@trails_json[:data][:attributes][:trails].first).to have_key(:distance_to_trail)
    expect(@trails_json[:data][:attributes][:trails].first).to_not have_key(:length)
    expect(@trails_json[:data][:attributes][:trails].first).to_not have_key(:ascent)
    expect(@trails_json[:data][:attributes][:trails].first).to_not have_key(:descent)
    expect(@trails_json[:data][:attributes][:trails].first).to_not have_key(:time)
  end
end
