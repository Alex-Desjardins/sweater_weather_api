require 'rails_helper'

RSpec.describe 'Forecast GET request' do
  before :each do
    VCR.use_cassette('Dallas forecast') do
      get '/api/v1/forecast?location=dallas,tx'
      @forecast_json = JSON.parse(response.body, symbolize_names: true)
    end
  end

  it 'forcast data for location; success' do
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(@forecast_json[:data]).to have_key(:id)
    expect(@forecast_json[:data][:type]).to eq("forecast")
    expect(@forecast_json[:data]).to have_key(:attributes)
    expect(@forecast_json[:data][:attributes]).to have_key(:id)
    expect(@forecast_json[:data][:attributes]).to have_key(:location)
    expect(@forecast_json[:data][:attributes]).to have_key(:current)
    expect(@forecast_json[:data][:attributes]).to have_key(:hourly)
    expect(@forecast_json[:data][:attributes]).to have_key(:daily)

    expect(@forecast_json[:data][:attributes][:location]).to have_key(:coordinates)
    expect(@forecast_json[:data][:attributes][:location]).to have_key(:city)
    expect(@forecast_json[:data][:attributes][:location]).to have_key(:state)
    expect(@forecast_json[:data][:attributes][:location]).to have_key(:country)

    expect(@forecast_json[:data][:attributes][:current]).to have_key(:time)
    expect(@forecast_json[:data][:attributes][:current]).to have_key(:sunrise)
    expect(@forecast_json[:data][:attributes][:current]).to have_key(:sunset)
    expect(@forecast_json[:data][:attributes][:current]).to have_key(:temp)
    expect(@forecast_json[:data][:attributes][:current]).to have_key(:feels_like)
    expect(@forecast_json[:data][:attributes][:current]).to have_key(:humidity)
    expect(@forecast_json[:data][:attributes][:current]).to have_key(:uvi)
    expect(@forecast_json[:data][:attributes][:current]).to have_key(:visibility)
    expect(@forecast_json[:data][:attributes][:current]).to have_key(:conditions)
    expect(@forecast_json[:data][:attributes][:current]).to have_key(:icon)

    expect(@forecast_json[:data][:attributes][:hourly].first).to have_key(:time)
    expect(@forecast_json[:data][:attributes][:hourly].first).to have_key(:temp)
    expect(@forecast_json[:data][:attributes][:hourly].first).to have_key(:wind_speed)
    expect(@forecast_json[:data][:attributes][:hourly].first).to have_key(:wind_direction)
    expect(@forecast_json[:data][:attributes][:hourly].first).to have_key(:conditions)
    expect(@forecast_json[:data][:attributes][:hourly].first).to have_key(:icon)

    expect(@forecast_json[:data][:attributes][:daily].first).to have_key(:date)
    expect(@forecast_json[:data][:attributes][:daily].first).to have_key(:sunrise)
    expect(@forecast_json[:data][:attributes][:daily].first).to have_key(:sunset)
    expect(@forecast_json[:data][:attributes][:daily].first).to have_key(:temp_high)
    expect(@forecast_json[:data][:attributes][:daily].first).to have_key(:temp_low)
    expect(@forecast_json[:data][:attributes][:daily].first).to have_key(:conditions)
    expect(@forecast_json[:data][:attributes][:daily].first).to have_key(:icon)
  end
end
