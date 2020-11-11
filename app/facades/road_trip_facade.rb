class RoadTripFacade
  def self.get_trip(origin, destination, user)
    mapping_data = MappingService.mapping_data(origin, destination)
    origin_data = LocationService.location_data(origin)
    destination_data = LocationService.location_data(destination)
    forecast_data = WeatherService.destination_forecast_data(destination_data[:latLng])
    travel_time = mapping_data[:route][:formattedTime] ||= "Impossible To Route"
    destination_forecast_data = destination_forecast(travel_time, destination)
    trip = RoadTrip.new(origin_data, destination_data, travel_time, destination_forecast_data)
  end

  def self.destination_forecast(travel_time, destination)
    destination_data = LocationService.location_data(destination)
    forecast_data = WeatherService.destination_forecast_data(destination_data[:latLng])
    hour = travel_time.split[0].to_i
    if travel_time.split[1].to_i > 30
      hour + 1
    end
    forecast_data[:hourly][hour - 1]
  end
end
