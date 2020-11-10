class ImageService
  def self.location_image(location)
    response = conn.get('v1/search') do |f|
      f.params[:query] = location
      f.params[:per_page] = 1
    end

    JSON.parse(response.body, symbolize_names: true)[:photos].first
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.pexels.com/') do |f|
      f.headers['Authorization'] = ENV['IMAGE_API_KEY']
    end
  end
end
