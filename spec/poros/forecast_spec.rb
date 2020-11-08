require 'rails_helper'

RSpec.describe Forecast do
  it 'has attributes' do
    VCR.use_cassette('Denver forecast') do
      location_data = {:adminArea5=>"Denver",
        :adminArea3=>"CO",
        :adminArea1=>"US",
        :latLng=>{:lat=>39.738453, :lng=>-104.984853}}

      location = Location.new(location_data)

      forecast_data = WeatherService.weather_forecast_data(location.coordinates)

      forecast = Forecast.new(location, forecast_data)

      expect(forecast).to be_a(Forecast)
      expect(forecast.id).to eq(nil)
      expect(forecast.location).to be_a(Location)
      expect(forecast.current).to be_a(Hash)
      expect(forecast.daily).to be_an(Array)
      expect(forecast.daily.count).to eq(5)
      expect(forecast.hourly).to be_an(Array)
      expect(forecast.hourly.count).to eq(8)
    end
  end
end
