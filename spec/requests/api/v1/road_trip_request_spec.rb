require 'rails_helper'

RSpec.describe 'Road trip POST request' do
  it 'Road trip creation with data; success' do
    VCR.use_cassette('Moab trip') do
      user = User.create(email: 'me@user.com',
                         password: '12345',
                         password_confirmation: '12345')

      trip_params = {
                      origin: "Denver,CO",
                      destination: "Moab,UT",
                      api_key: user.api_key
                    }

      header = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/road_trip', headers: header, params: JSON.generate(trip_params)
      trip_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.content_type).to eq('application/json')

      expect(trip_json[:data][:type]).to eq("road_trip")
      expect(trip_json[:data][:attributes].keys.count).to eq(4)
      expect(trip_json[:data][:attributes][:origin]).to eq(trip_params[:origin])
      expect(trip_json[:data][:attributes][:destination]).to eq(trip_params[:destination])
      expect(trip_json[:data][:attributes][:travel_time]).to be_a(String)
      expect(trip_json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(trip_json[:data][:attributes][:weather_at_eta].keys.count).to eq(2)
      expect(trip_json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(trip_json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      expect(trip_json[:data][:attributes]).to_not have_key(:api_key)
    end
  end

  it '40 hour road trip creation with data; success' do
    VCR.use_cassette('LosAngeles trip') do
      user = User.create(email: 'me@user.com',
                         password: '12345',
                         password_confirmation: '12345')

      trip_params = {
                      origin: "New York,NY",
                      destination: "Los Angeles,CA",
                      api_key: user.api_key
                    }

      header = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/road_trip', headers: header, params: JSON.generate(trip_params)
      trip_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.content_type).to eq('application/json')

      expect(trip_json[:data][:type]).to eq("road_trip")
      expect(trip_json[:data][:attributes].keys.count).to eq(4)
      expect(trip_json[:data][:attributes][:origin]).to eq(trip_params[:origin])
      expect(trip_json[:data][:attributes][:destination]).to eq(trip_params[:destination])
      expect(trip_json[:data][:attributes][:travel_time]).to be_a(String)
      expect(trip_json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(trip_json[:data][:attributes][:weather_at_eta].keys.count).to eq(2)
      expect(trip_json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(trip_json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      expect(trip_json[:data][:attributes]).to_not have_key(:api_key)
    end
  end

  it 'Impossible road trip creation with data; fail' do
    VCR.use_cassette('London trip') do
      user = User.create(email: 'me@user.com',
                         password: '12345',
                         password_confirmation: '12345')

      trip_params = {
                      origin: "New York,NY",
                      destination: "London,ENG",
                      api_key: user.api_key
                    }

      header = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/road_trip', headers: header, params: JSON.generate(trip_params)
      trip_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.content_type).to eq('application/json')

      expect(trip_json[:data][:type]).to eq("road_trip")
      expect(trip_json[:data][:attributes].keys.count).to eq(4)
      expect(trip_json[:data][:attributes][:origin]).to eq(trip_params[:origin])
      expect(trip_json[:data][:attributes][:destination]).to eq(trip_params[:destination])
      expect(trip_json[:data][:attributes][:travel_time]).to eq('Impossible To Route')
      expect(trip_json[:data][:attributes][:weather_at_eta]).to eq(nil)
      expect(trip_json[:data][:attributes]).to_not have_key(:api_key)
    end
  end

  it 'Invalid API key; fail' do
    VCR.use_cassette('Dallas trip') do
      user = User.create(email: 'me@user.com',
                         password: '12345',
                         password_confirmation: '12345')

      trip_params = {
                      origin: "New York,NY",
                      destination: "Dallas,TX",
                      api_key: "kjsdhfkshrkbvbsdoi209"
                    }

      header = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/road_trip', headers: header, params: JSON.generate(trip_params)
      request_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(response.content_type).to eq('application/json')
      expect(request_json[:error]).to eq("API Key Invalid")
    end
  end
end
