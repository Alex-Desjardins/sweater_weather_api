class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_id{nil}
  attributes :location, :current, :hourly, :daily
end
