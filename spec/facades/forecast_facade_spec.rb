require 'rails_helper'

RSpec.describe ForecastFacade do
  it '::get_location' do
    VCR.use_cassette('Miami location') do
      location = ForecastFacade.get_location('Miami,FL')
      expect(location).to be_a(Location)
    end
  end

  it '::get_forecast' do
    VCR.use_cassette('Miami forecast') do
      forecast = ForecastFacade.get_forecast('Miami,FL')
      expect(forecast).to be_a(Forecast)
      expect(forecast.location).to be_a(Location)
    end
  end
end
