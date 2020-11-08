class ForecastFacade
  def self.get_location(location)
    location_data = LocationService.location_data(location)
    Location.new(location_data)
  end

  def self.get_forecast(location)
    location = get_location(location)
    forecast_data = WeatherService.weather_forecast_data(location.coordinates)
    Forecast.new(location, forecast_data)
  end
end
