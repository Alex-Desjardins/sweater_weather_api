class Forecast
  attr_reader :id, :location

  def initialize(location, forecast_data)
    @location = location
    @current = forecast_data[:current]
    @hourly = forecast_data[:hourly]
    @daily = forecast_data[:daily]
  end

  def current
    {
      time: datetime(@current[:dt]),
      sunrise: datetime(@current[:sunrise]),
      sunset: datetime(@current[:sunset]),
      temp: @current[:temp],
      feels_like: @current[:feels_like],
      humidity: @current[:humidity],
      uvi: @current[:uvi],
      visibility: @current[:visibility],
      conditions: @current[:weather].first[:description],
      icon: "http://openweathermap.org/img/wn/#{@current[:weather].first[:icon]}.png",
    }
  end

  def hourly
    @hourly.first(8).map do |hourly|
      {
        time: time(hourly[:dt]),
        temp: hourly[:temp],
        wind_speed: "#{hourly[:wind_speed]} mph",
        wind_direction: "from #{wind_direction(hourly[:wind_deg])}",
        conditions: hourly[:weather].first[:description],
        icon: "http://openweathermap.org/img/wn/#{hourly[:weather].first[:icon]}.png"
      }
    end
  end

  def daily
    @daily.first(5).map do |daily|
      {
        date: date(daily[:dt]),
        sunrise: time(daily[:sunrise]),
        sunset: time(daily[:sunset]),
        temp_high: daily[:temp][:max],
        temp_low: daily[:temp][:min],
        conditions: daily[:weather].first[:description],
        icon: "http://openweathermap.org/img/wn/#{daily[:weather].first[:icon]}.png"
      }
    end
  end

  private

  def date(datetime)
    Time.at(datetime).strftime('%D')
  end

  def time(datetime)
    Time.at(datetime).strftime('%T')
  end

  def datetime(datetime)
    Time.at(datetime)
  end

  def wind_direction(deg)
    val = (deg/22.5)+0.5
    dir = ["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
    dir[(val % 16)]
  end
end
