class TrailService
  def self.trail_data(coordinates)
    response = conn.get('data/get-trails') do |f|
      f.params[:lat] = coordinates[:lat]
      f.params[:lon] = coordinates[:lng]
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'https://www.hikingproject.com/') do |f|
      f.params[:key] = ENV['HIKING_API_KEY']
    end
  end
end
