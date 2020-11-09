class Trail
  attr_reader :id, :location, :forecast, :trails

  def initialize(location, forecast, trail_data)
    @location = "#{location[:adminArea5]},#{location[:adminArea3]}"
    @forecast = forecast[:current]
    @trails = trail_data[:trails]
  end

  def forecast
    {
      summary: @forecast[:weather].first[:description],
      temp: @forecast[:temp].round(0).to_s
    }
  end

  def trails
    @trails.map do |trail|
      trail_coordinates = "#{trail[:latitude]},#{trail[:longitude]}"
      {
      name: trail[:name],
      summary: trail[:summary],
      difficulty: trail[:difficulty],
      location: trail[:location],
      distance_to_trail: mapping_points(@location, trail_coordinates)[:route][:distance].to_s
      }
    end
  end

  private

  def mapping_points(start, stop)
    MappingService.mapping_data(start, stop)
  end
end
