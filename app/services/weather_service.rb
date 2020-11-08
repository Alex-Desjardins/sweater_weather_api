class WeatherService
  def self.weather_forecast_data(coordinates)
    response = conn.get('data/2.5/onecall') do |f|
      f.params[:lat] = coordinates[:lat]
      f.params[:lon] = coordinates[:lng]
      f.params[:exclude] = 'minutely,alerts'
      f.params[:units] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org/') do |f|
      f.params[:appid] = ENV['WEATHER_API_KEY']
    end
  end
end
