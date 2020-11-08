require 'rails_helper'

RSpec.describe WeatherService do
  it 'can return weather forecast when passed coordinates' do
    VCR.use_cassette('Denver forecast') do
      coordinates = {:lat=>39.738453, :lng=>-104.984853}

      results = WeatherService.weather_forecast_data(coordinates)
      expect(results).to be_a(Hash)
      expect(results).to have_key(:current)
      expect(results).to have_key(:hourly)
      expect(results).to have_key(:daily)
      expect(results).to_not have_key(:minutely)
      expect(results).to_not have_key(:alerts)
    end
  end
end
