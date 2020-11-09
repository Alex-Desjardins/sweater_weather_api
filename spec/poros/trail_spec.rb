require 'rails_helper'

RSpec.describe Trail do
  it 'has attributes' do
    VCR.use_cassette('Telluride poro') do
      location_data = {:adminArea5=>"Telluride",
        :adminArea3=>"CO",
        :adminArea1=>"US",
        :latLng=>{:lat=>37.937412, :lng=>-107.811757}}

      forecast_data = WeatherService.weather_forecast_data(location_data[:latLng])

      trail_data = TrailService.trail_data(location_data[:latLng])

      trail = Trail.new(location_data, forecast_data, trail_data)

      expect(trail).to be_a(Trail)
      expect(trail.location).to be_a(String)
      expect(trail.location).to eq("Telluride,CO")

      expect(trail.forecast).to be_a(Hash)
      expect(trail.forecast).to have_key(:summary)
      expect(trail.forecast[:summary]).to eq(forecast_data[:current][:weather].first[:description])
      expect(trail.forecast).to have_key(:temp)
      expect(trail.forecast[:temp]).to eq(forecast_data[:current][:temp].round(0))

      expect(trail.trails).to be_an(Array)
      expect(trail.trails.first).to have_key(:name)
      expect(trail.trails.first[:name]).to eq(trail_data[:trails].first[:name])
      expect(trail.trails.first).to have_key(:summary)
      expect(trail.trails.first[:summary]).to eq(trail_data[:trails].first[:summary])
      expect(trail.trails.first).to have_key(:difficulty)
      expect(trail.trails.first[:difficulty]).to eq(trail_data[:trails].first[:difficulty])
      expect(trail.trails.first).to have_key(:location)
      expect(trail.trails.first[:location]).to eq(trail_data[:trails].first[:location])
      expect(trail.trails.first).to have_key(:distance_to_trail)
    end
  end
end
