class LocationService
  def self.location_data(location)
    response = conn.get('geocoding/v1/address') do |f|
      f.params[:location] = location
    end
    JSON.parse(response.body, symbolize_names: true)[:results].first[:locations].first
  end

  private

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
      f.params[:key] = ENV['MAPPING_API_KEY']
    end
  end
end
