class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  set_id{nil}
  attributes :origin, :destination, :travel_time, :weather_at_eta
end
