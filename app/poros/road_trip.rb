class RoadTrip
  attr_reader :origin, :destination, :travel_time, :weather_at_eta

  def initialize(origin_data, destination_data, travel_time, destination_forecast_data)
    @origin = "#{origin_data[:adminArea5]},#{origin_data[:adminArea3]}"
    @destination = "#{destination_data[:adminArea5]},#{destination_data[:adminArea3]}"
    @travel_time = travel_time
    @weather_at_eta = {"temperature": destination_forecast_data[:temp], "conditions": destination_forecast_data[:weather][0][:description]} unless travel_time == "Impossible To Route"
  end
end
