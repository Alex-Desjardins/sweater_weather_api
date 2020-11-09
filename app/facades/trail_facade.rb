class TrailFacade
  def self.get_location(location)
    location_data = LocationService.location_data(location)
  end


  def self.get_forecast(location)
    location_data = get_location(location)
    forecast_data = WeatherService.weather_forecast_data(location_data[:latLng])
  end

  def self.get_trail(location)
    location_data = get_location(location)
    forecast_data = get_forecast(location)
    trail_data = TrailService.trail_data(location_data[:latLng])
    trail = Trail.new(location_data, forecast_data, trail_data)
  end
end
